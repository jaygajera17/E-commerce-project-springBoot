import Home from "../models/homeModal.js";
import asyncHandler from "express-async-handler";
import fs from "fs";

//@desc   get all homes list
//@route  GET /api/homes
//@access Public
const getAllHomes = asyncHandler(async (req, res) => {
  const homes = await Home.find({});
  res.json(homes);
});

//@desc   get all homes list by user
//@route  GET /api/homes
//@access Private
const getUserHomes = asyncHandler(async (req, res) => {
  const homes = await Home.find({ posted_by: req.user._id });
  res.json(homes);
});

//@desc   Create new home
//@route  POST /api/homes
//@access Private
const addNewHome = asyncHandler(async (req, res) => {
  console.log("In add home");
  console.log(req.body);
  let {
    address,
    city,
    state,
    postalCode,
    country,
    images,
    price,
    type,
    rooms,
    washrooms,
    size,
    // position,
    details,
  } = req.body;
  var sameHome = await Home.find({
    address,
    city,
    state,
    postalCode,
   // position,
  });
  if (sameHome.length > 0) {
    throw new Error(
      "Same address property already added please check address and try again"
    );
  } else {
    const home = new Home({
      address,
      city,
      state,
      postalCode,
      country,
     // position,
      images,
      price,
      type,
      date: new Date(),
      rooms,
      washrooms,
      size,
      details,
      posted_by: req.user._id,
    });
    try {
      console.log(home);
      const createdHome = await home.save();
      res.status(201).json(createdHome);
    } catch (e) {
      console.log(e);
      throw e;
      // throw new Error(
      //   "Something went wrong please check all inputs and try again"
      // );
    }
  }
});

// @desc    Update a home
// @route   PUT /api/homes:id
// @access  Private/Admin
const updateHome = asyncHandler(async (req, res) => {
  const {
    address,
    city,
    state,
    postalCode,
    country,
    images,
    price,
    type,
    rooms,
    washrooms,
    size,
   // position,
    details,
  } = req.body;
  const home = await Home.findById(req.params.id);

  if (home) {
    if (home.posted_by.equals(req.user._id)) {
      home.address.address = address;
      home.address.city = city;
      home.address.state = state;
      home.address.postalCode = postalCode;
      home.address.country = country;
     // home.address.position = position;
      home.images = images;
      home.price = price;
      home.type = type;
      home.date = date;
      home.rooms = rooms;
      home.washrooms = washrooms;
      home.size = size;
      home.details = details;
      // home.posted_by = req.user._id;

      const updatedHome = await Home.save();
      res.status(201).json(updatedHome);
    } else {
      throw new Error("User Verification Failed");
    }
  } else {
    res.status(404);
    throw new Error("Home Not Found");
  }
});

// @desc    DELETE a home and images linked to home
// @route   DELETE /api/homes/:id
// @access  Private/Admin
const deleteHome = asyncHandler(async (req, res) => {
  const home = await Home.findById(req.params.id);
  if (home) {
    if (home.posted_by.equals(req.user._id)) {
      //removing images of the home
      home.images.map((image) => {
        fs.unlinkSync(image);
      });
      await home.remove();
      res.json({ message: "Home removed" });
    } else {
      throw new Error("User Verification Failed");
    }
  } else {
    res.status(404);
    throw new Error("Home not found");
  }
});

export { getAllHomes, getUserHomes, addNewHome, updateHome, deleteHome };
