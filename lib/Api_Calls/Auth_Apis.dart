import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nodexflutter/Models/user.dart';
class AuthApi{
  Dio dio = Dio();

  Future<bool> login(UserModel loginCred)async{
    await dotenv.load(fileName: ".env");
    String url = "/login";
    try{
      Response response = await dio.post(
          dotenv.env['USER_URL$url']!,
          data: loginCred.toJson()
      );
      log('Response ${response.data.toString()}');

      if(response.statusCode == 200){
        log("Login Successfully");
        log("Status code is :: ${response.statusCode.toString()}");
        return true;
      }
    }on DioException catch(e){
      print("Error :: ${e.toString()}");
    }
    return false;
  }
}
