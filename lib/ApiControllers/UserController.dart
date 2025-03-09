import 'package:nodexflutter/Api_Calls/Auth_Apis.dart';
import 'package:nodexflutter/Models/user.dart';

class UserController{
  AuthApi authApi = AuthApi();
  late UserModel loginCred;
  late UserModel signupCred;
  late UserModel forgetCred;
  late UserModel otpCred;
  late UserModel resetCred;
  UserController(this.authApi);

  Future<void> loginInfo({required String email,required String password})async{
    loginCred = UserModel(email: email, password: password);
  }

  Future<void> signupInfo({required String username,required String fullname,required String email,required String password})async{
    signupCred = UserModel(username: username,fullname: fullname ,email: email, password: password);
  }

  Future<void> forgetInfo({required String email})async{
    forgetCred = UserModel(email: email);
  }

  Future<void> otpInfo({required String email,required String otp})async{
    otpCred = UserModel(email: email,otp: otp);
  }

  Future<void> resetInfo({required String email,required String newPassword,required String confirmPassword})async{
    resetCred = UserModel(email: email, newPassword: newPassword,confirmPassword: confirmPassword);
  }

}