import { Router } from "express";
import {registerUser,loginUser,logoutUser,changePassword,getUser,forgetPassword,changePassWithOtp,chkOTP} from "../controllers/user.controllers.js"
import { JWTverify } from "../middlewares/auth.middleware.js";

const user = Router()

user.route('/register').post(registerUser)
user.route('/login').post(loginUser)
user.route('/logout').post(JWTverify,logoutUser)
user.route('/getUser').post(JWTverify,getUser)
user.route('/change-password').post(JWTverify,changePassword)
user.route('/forget').post(forgetPassword)
user.route('/check-otp').post(chkOTP)
user.route('/changePassWithOtp').post(changePassWithOtp)
export {user}