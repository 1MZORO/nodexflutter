import mongoose, { Schema } from "mongoose";

const ProductVariantsSchema = new Schema(
  {
    products_id: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Products",
      required: true,
    },
    mainImage: {
      required: true,
      type: {
        url: String,
        localPath: String,
      },
    },
    subMainImages: {
      type: [
        {
          url: String,
          localPath: String,
        },
      ],
      default: [],
    },
    color: {
      type: String,
    },
    size: {
      type: String,
    },
    price: {
      type: Number,
      required: true,
      default: 0,
    },
    StockQuantity: {
      type: Number,
      default: 0,
    },
    status: {
      type: String,
      enum: ["active", "inactive", "default"],
      default: "active",
    },
  },
  { timestamps: true }
);


export const ProductVariants = mongoose.model(
  "ProductVariants",
  ProductVariantsSchema
);