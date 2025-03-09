import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:nodexflutter/Models/user.dart';
import 'package:nodexflutter/Screens/Forgot/ResetPasswordScreen.dart';
import '../LocalStorage/SecureStorage.dart';

class AuthApi{
  Dio dio = Dio();
  final SecureStorage storage = SecureStorage();
  String url = "http://10.0.2.2:8000/api/v1/users";

  Future<bool> signup(UserModel signupCred)async{
    try{
      Response response = await dio.post(
        // dotenv.env['USER_URL$url']!,
          '$url/register',
          data: signupCred.toJson()
      );
      log('Response ${response.data.toString()}');
      log('Response token ${response.data['data']['accessToken'].toString()}');
      if(response.statusCode == 200){
        String s = response.data['data']['accessToken'].toString();
        print("SSSSSS $s");
        await storage.saveData('jwtToken', s);
        String? token = await storage.readData('jwtToken');
        log( '::::::: $token');
        log("Signup Successfully");
        log("Status code is :: ${response.statusCode.toString()}");
        return true;
      }
    }on DioException catch(e){
      print("Error :: ${e.toString()}");
    }
    return false;
  }

  Future<bool> login(UserModel loginCred)async{
    // String url = "/login";
    try{
      Response response = await dio.post(
          // dotenv.env['USER_URL$url']!,
          '$url/login',
          data: loginCred.toJson()
      );
      log('Response ${response.data.toString()}');
      log('Response token ${response.data['data']['accessToken'].toString()}');
      if(response.statusCode == 200){
        String s = response.data['data']['accessToken'].toString();
        print("SSSSSS $s");
        await storage.saveData('jwtToken', s);
        String? token = await storage.readData('jwtToken');
        log( '::::::: $token');
        log("Login Successfully");
        log("Status code is :: ${response.statusCode.toString()}");
        return true;
      }
    }on DioException catch(e){
      print("Error :: ${e.toString()}");
    }
    return false;
  }


  Future<bool> logout()async{
    try{
        String? token = await storage.readData('jwtToken');
        dio.options.headers['Authorization'] = 'Bearer $token';
        final response = await dio.post('$url/logout');
        if(response.statusCode == 200){
          log("Logout Successfully");
          log("Status code is :: ${response.statusCode.toString()}");
          return true;
        }
    }on DioException catch(e){
      print("Error :: ${e.toString()}");
    }
    return false;
  }

  Future<bool>forget(UserModel forgetCred)async{
    try{
      final response = await dio.post(
        '$url/forget',
        data: forgetCred.toJson()
      );
      if(response.statusCode == 200){
        log("forget Successfully");
        log("Status code is :: ${response.statusCode.toString()}");
        return true;
      }
    }on DioException catch(e){
      print("Error :: ${e.toString()}");
    }
    return false;
  }

  Future<bool>otp(UserModel otpCred)async{
    try{
      print('::::::::');
      print(otpCred.toJson());
      final response = await dio.post(
          '$url/check-otp',
          data: otpCred.toJson()
      );
      if(response.statusCode == 200){
        log("OTP is Valid ");
        log("Status code is :: ${response.statusCode.toString()}");
        return true;
      }
    }on DioException catch(e){
      print("Error :: ${e.toString()}");
    }
    return false;
  }

  Future<bool>reset(UserModel resetCred)async{
    try{
      print('::::::::');
      print(resetCred.toJson());
      final response = await dio.post(
          '$url/changePassWithOtp',
          data: resetCred.toJson()
      );
      if(response.statusCode == 200){
        log("Password forget successfully ");
        log("Status code is :: ${response.statusCode.toString()}");
        return true;
      }
    }on DioException catch(e){
      print("Error :: ${e.toString()}");
    }
    return false;
  }

}