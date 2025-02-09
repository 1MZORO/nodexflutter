import { asyncHandler } from "../utils/asyncHandler.js";
import {apiError} from "../utils/apiError.js"
import { User } from "../models/user.model.js"
import { apiResponce } from "../utils/apiResponce.js";
import sendEmail from "../utils/emailSend.js";
// import OTP from "../models/otp.model.js";
// import Redis from "ioredis"

// const redis = new Redis();
const accessAndRefreshTokenGenrator = async(userId) => {
    try{
        const user = await User.findById(userId)
        const accessToken = user.generateAccessToken()
        const refreshToken = user.generateRefreshToken()
        //console.log("user id ",user,accessToken,refreshToken);

        user.refreshToken = refreshToken
        await user.save({validateBeforeSave : false})
        return {accessToken,refreshToken}
    }catch(e){
        console.error(e)
        throw new apiError(500,"something went wrong while generating refresh and access token")
    }

}

const registerUser = asyncHandler( async (req,res) => {
    console.log(req.body)
    const {email,username,fullname,password} = req.body

    if([email,username,fullname,password].some((fields)=>fields?.trim() === "")){
        throw new apiError(400,"All fields are required")
    }
    
    console.log(req.body)
    console.log("email ",email)
    const existedUser = await User.findOne(
        {
            $or:[
                {email},
                {username}
            ]
        }
    )

    if(existedUser){
        throw new apiError(409,"User Already Exist")
    }

    const user = await User.create(
        {
            email,
            username: username.toLowerCase(),
            fullname,
            password
        }
    )

    const createdUser = await User.findById(user._id).select("-password -refreshToken")

    if(!createdUser){
        throw new apiError(500,"User registration failed")
    }

    return res.status(200).json(
        new apiResponce(200,"User Registered Successfully !!",createdUser)
    )
} )

const loginUser = asyncHandler(async(req,res) => {
    const {username,email,password} = req.body

    if([email,username,password].some((fields)=>fields?.trim() === "")){
        throw new apiError(400,"All fields are required")
    }

    const user = await User.findOne(
        {
            $or:[
                {email},
                {username}
            ]
        }
    )

    if(!user){
        throw new apiError(409,"User Not Exist")
    }

    console.log("Pass : ",password)
    const isPasswordValid = await user.isPasswordCorrect(password)
    console.log("isPasswordValid : ",isPasswordValid)
    if(!isPasswordValid){
        throw new apiError(401,"Password Incorrect ")
    }
    // console.log("id ",user._id);
    const {accessToken,refreshToken} = await accessAndRefreshTokenGenrator(user._id)

    const logginedUser = await User.findById(user._id).select("-password -refreshToken")

    const options = {
        httpOnly:true,
        secure:true
    }
//    console.log("Ref Tok ",refreshToken)
    return res.status(200)
    .cookie("accessToken",accessToken,options)
    .cookie("refreshToken",refreshToken.option)
    .json(
        new apiResponce(200,"Login Successfully !!",{logginedUser,accessToken}),
    )

})

const logoutUser = asyncHandler(async (req,res)=>{
    await User.findByIdAndUpdate(
        req.user._id,
        {
            $unset:{
                refreshToken:1
            }
        },{
            new:true
        }
    )

    const options = {
        httpOnly:true,
        secure:true
    }

    return res.status(200).clearCookie("accessToken",options).clearCookie("refreshToken",options).json(
        new apiResponce(200,"Logout Successfully !!",{})
    )
    
})

const getUser = asyncHandler(async(req,res)=>{
    return res
    .status(200)
    .json(
        new apiResponce(
            200,
            "User featched successfully",
            req.user
        )
    )
})

const changePassword = asyncHandler(async(req,res)=>{
    const {oldPassword , newPassword ,confirmPassword} = req.body

    const user = await User.findById(req.user._id)

    if([oldPassword,newPassword,confirmPassword].some((fields)=>fields?.trim() === "")){
        throw new apiError(401,"All fields are required ")
    }

    if(!(oldPassword && newPassword && confirmPassword)){
        throw new apiError(401,"All fields are required ")
    }

    if(!(newPassword === confirmPassword)){
        throw new apiError(401,"Password are not same !!")
    }

    const isValid = user.isPasswordCorrect(oldPassword)

    if(!isValid){
        throw new apiError(400,"Wrong credentials")
    }

    user.password = newPassword
    await user.save({validateBeforeSave:true})

    return res.status(200)
    .json(
        new apiResponce(
            200,
            "Password Changed Successfully !!",
            {}
        ))

    })       

const forgetPassword = asyncHandler(async(req,res)=>{
    const {email} = req.body
    console.log("Start IMP1 :: ",email);
    if(!email){
        throw new apiError(400,"Email is required")
    }

    const user = await User.findOne({email});
    console.log("User :::",user)

    if(!user){
        throw new apiError(401,"User not Found")
    }

    const resetCode = Math.floor(100000 + Math.random() * 900000).toString();
    user.otp = resetCode
    await user.save({validateBeforeSave:true})
    // await redis.setex(`resetCode:${email}`, 600, resetCode); 
    sendEmail(email,"Testing",resetCode)
    console.log("Over IMP1 ::");
    return res
    .status(200)
    .json(
        new apiResponce(
            200,
            "OTP send in your mail successfully",
            {"email":email}
        )
    )
})

const chkOTP = asyncHandler(async(req,res)=>{
    const {email,otp} = req.body
    console.log("Start IMP2 :: ",email,otp);
    if(!email){
        throw new apiError(400,"Email is required")
    }
    if(!otp){
        throw new apiError(400,"OTP is required ")
    }

    const user = await User.findOne({email});
    console.log("User :::",user)

    if(!user){
        throw new apiError(401,"User not Found")
    }

    const resetCode = user.otp;

    if(!(resetCode === otp)){
        throw new apiError(401,"Wrong OTP ")
    }

    await User.findByIdAndUpdate(user._id,{$unset:{otp : "null" }})
    console.log("Over2 ::");
    return res
    .status(200)
    .json(
        new apiResponce(
            200,
            "OPT Verified successfully",
            {"email":email}
        )
    )

})

const changePassWithOtp = asyncHandler(async(req,res)=>{
    const {email, newPassword ,confirmPassword} = req.body
    console.log("Strt IMP3 ::",email,newPassword,confirmPassword);
    if(!email){
        throw new apiError(400,"Email is required")
    }

    const user = await User.findOne({email});
    console.log("User :::",user)

    if(!user){
        throw new apiError(401,"User not Found")
    }

    if(!(newPassword === confirmPassword)){
        throw new apiError(401,"Password are not same !!")
    }

    user.password = newPassword
    await user.save({validateBeforeSave:true})
    console.log("Over3 ::");
    return res.status(200)
    .json(
        new apiResponce(
            200,
            "Password Changed Successfully !!",
            {}
        ))

})

export {registerUser,loginUser,logoutUser,changePassword,getUser,forgetPassword,changePassWithOtp,chkOTP}