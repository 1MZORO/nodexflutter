import mongoose from "mongoose";

const ProductSchema = mongoose.Schema(
    {
        productname: {
          type: String,
          required: true,
        },
        category_id: {
          type: mongoose.Schema.Types.ObjectId,
          ref: "Category",
          required: true,
        },
        description: {
          type: String,
        },
      },
      { timestamps: true }
)

export const Product = mongoose.model("Product", ProductSchema);