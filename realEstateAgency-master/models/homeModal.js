import mongoose from "mongoose";

// const homeSchema = mongoose.Schema(
//   {
//     title: { type: String, required: true },
//     address: { type: String, required: true },
//     images: [String],
//     price: { type: Number, required: true },
//     type: { type: String, required: true },
//     date: Date,
//     rooms: { type: Number, required: true },
//     washrooms: { type: Number, required: true },
//     pets: Boolean,
//     size: { type: Number },
//     position: {
//       lat: Number,
//       lng: Number,
//     },
//     details: String,
//   },
//   {
//     timestamps: true,
//   }
// );
const homeSchema = mongoose.Schema(
  {
    address: { type: String, required: true },
    city: { type: String, required: true },
    state: { type: String, required: true },
    postalCode: { type: String, required: true },
    country: { type: String, required: true },
    // position: {
    //   lat: Number,
    //   lng: Number,
    // },
    images: [String],
    price: { type: Number, required: true },
    type: { type: String, required: true },
    date: Date,
    rooms: { type: Number, required: true },
    washrooms: { type: Number, required: true },
    size: { type: Number, required: true },
    details: String,
    posted_by: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "User",
    },
  },
  {
    timestamps: true,
  }
);

const Home = mongoose.model("Home", homeSchema);

export default Home;
