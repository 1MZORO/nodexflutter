import express from 'express';
import cookieParser from 'cookie-parser';
import cors from 'cors';
// import Redis from "ioredis";
const app = express();
// const redis = new Redis();
app.use(cors(
    {
        origin: process.env.CORS_ORIGIN,
        credentials: true
    }
));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static("public"));
app.use(cookieParser());
// redis.on("error", (err) => {
//     console.error("⚠ Redis Connection Error:", err.message);
// });


// Routes
import {user} from "./routes/user.route.js"

app.use("/api/v1/users",user)

export {app};