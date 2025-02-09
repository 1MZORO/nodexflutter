import mongoose from "mongoose";
import { DB_NAME } from "../constrants.js";
import dotenv from "dotenv";
dotenv.config();

const connectToDatabase = async () => {
    try{
        console.log(DB_NAME)
       const a =  await mongoose.connect(`${process.env.MONGODB_URL}/${DB_NAME}`)
        console.log(`Connection Established Successfully !! ${a.connection.host}`)
    }catch(error){
        console.log("Mongo DB Connection failed !!")
        console.error("Error :",error)
    }
}

export default connectToDatabase