import User from "../models/userModal.js";
import asyncHandler from "express-async-handler";
import generateToken from "../utils/generateTokens.js";

//@desc   get all users list
//@route  GET /api/users
//@access Public
const getAllUsers = asyncHandler(async (req, res) => {
  const users = await User.find({});
  res.json(users);
});

//@desc   Register new user
//@route  POST /api/users
//@access Public
const addNewUser = asyncHandler(async (req, res) => {
  let { name, email, password } = req.body;

  const userExist = await User.findOne({ email });
  if (userExist) {
    res.status(400);
    throw new Error("User already exists");
  }

  const user = await User.create({
    name,
    email,
    password,
  });
  if (user) {
    res.status(201).json({
      _id: user._id,
      name: user.name,
      email: user.email,
      isAdmin: user.isAdmin,
      token: generateToken(user._id),
    });
  } else {
    res.status(400);
    throw new Error("Invalid user data");
  }
});

// @desc     Auth the user & get token
// @route    GET /api/users/login
// @access   Public
const authUser = asyncHandler(async (req, res) => {
  const { email, password } = req.body;
  const user = await User.findOne({ email });

  const token = generateToken(user._id);
  console.log(token);
  if (user && (await user.matchPassword(password))) {
    res.json({
      _id: user._id,
      name: user.name,
      email: user.email,
      isAdmin: user.isAdmin,
      profileImg: user.profileImg,
      token: token,
    });
  } else {
    res.status(401);
    throw new Error("Invalid username or password");
  }
});

// @desc     get user profile
// @route    GET /api/users/:id
// @access   Private/admin
const getUserById = asyncHandler(async (req, res) => {
  const user = await User.findById(req.params.id).select("-password");
  if (user) {
    res.json(user);
  } else {
    req.status(404);
    throw new Error("User not found");
  }
});

// @desc     get user profile
// @route    GET /api/users/profile
// @access   Private
const getUserProfile = asyncHandler(async (req, res) => {
  const user = await User.findById(req.user._id);

  if (user) {
    res.json({
      _id: user._id,
      name: user.name,
      email: user.email,
      profileImg: user.profileImg,
      isAdmin: user.isAdmin,
    });
  } else {
    res.status(404);
    throw new Error("User not found");
  }
});

// @desc     Update user profile
// @route    PUT /api/users/profile
// @access   Private
const updateUserProfile = asyncHandler(async (req, res) => {
  const user = await User.findById(req.user._id);

  if (user) {
    user.name = req.body.name || user.name;
    user.email = req.body.email || user.email;
    if (req.body.currentPassword && req.body.newPassword) {
      const match = await bcrypt.compare(
        req.body.currentPassword,
        user.password
      );
      if (match) {
        user.password = req.body.newPassword;
      } else {
        res.status(401);
        throw new Error("Password do not match");
      }
    }

    const updateUser = await user.save();

    res.json({
      _id: updateUser._id,
      name: updateUser.name,
      email: updateUser.email,
      isAdmin: updateUser.isAdmin,
    });
    //not sure if we shd pass token
    // token: generateToken(user._id),
  } else {
    res.status(404);
    throw new Error("User not found");
  }
});

// @desc     Delete a user
// @route    DELETE /api/users/:id
// @access   Private/Admin
const deleteUser = asyncHandler(async (req, res) => {
  const user = await User.findById(req.params.id);
  if (user) {
    await user.remove();
    res.json({ message: "User removed" });
  } else {
    req.status(404);
    throw new Error("User not found");
  }
});

// @desc     Update user
// @route    PUT /api/users/:id
// @access   Private/Admin
const updateUser = asyncHandler(async (req, res) => {
  const user = await User.findById(req.params.id);

  if (user) {
    user.name = req.body.name || user.name;
    user.email = req.body.email || user.email;
    user.isAdmin = req.body.isAdmin;

    const updateUser = await user.save();

    res.json({
      _id: updateUser._id,
      name: updateUser.name,
      email: updateUser.email,
      isAdmin: updateUser.isAdmin,
    });
  } else {
    res.status(404);
    throw new Error("User not found");
  }
});

export {
  getAllUsers,
  addNewUser,
  authUser,
  getUserById,
  updateUserProfile,
  deleteUser,
  updateUser,
  getUserProfile,
};
