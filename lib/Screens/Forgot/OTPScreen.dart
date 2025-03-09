import 'package:flutter/material.dart';
import 'package:nodexflutter/Screens/Forgot/ResetPasswordScreen.dart';

import '../../ApiControllers/UserController.dart';
import '../../Api_Calls/Auth_Apis.dart';
import '../../Utils/CustomTF.dart';
import '../../Utils/ShowSnackBar.dart';
class OTPScreen extends StatelessWidget {
  final email ;
  OTPScreen({super.key, required this.email});
  final _otpClt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey.shade200),
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('OTP',
                          style: Theme.of(context).textTheme.headlineLarge),
                    ],
                  ),
                ),
                CustomTF(
                  clt: _otpClt,
                  txt: "Enter 6 digit OTP ",
                  obscureText: false,
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                ElevatedButton(onPressed: ()async{
                  final authApi = AuthApi();
                  final userController = UserController(authApi);
                  userController.otpInfo(email: email, otp: _otpClt.text);
                  await authApi.otp(userController.otpCred).then((value)async{
                    if(value){
                      showSnackBar(context, "Password forget Successfully");
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>ResetPasswordScreen(email: email,)));
                    }else{
                      showSnackBar(context, "Invalid OTP Failed");
                    }
                  });
                }, child: Text('Continue'))
              ]
              )

          ),
        ));
  }
}
