import mongoose from "mongoose";

const propertySchema = mongoose.Schema(
  {
    address: {
      address: { type: String, required: true },
      city: { type: String, required: true },
      state: { type: String, required: true },
      postalCode: { type: String, required: true },
      country: { type: String, required: true },
      // position: {
      //   lat: Number,
      //   lng: Number,
      //   default: { lat: 38.8951, lng: -77.0364 },
      // },
    },
    images: [String],
    price: { type: Number, required: true },
    type: { type: String, required: true },
    date: Date,
    rooms: { type: Number, required: true },
    washrooms: { type: Number, required: true },
    pets: Boolean,
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

const Property = mongoose.model("Property", propertySchema);

export default Property;
