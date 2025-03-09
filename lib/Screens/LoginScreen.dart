import 'package:flutter/material.dart';
import 'package:nodexflutter/ApiControllers/UserController.dart';
import 'package:nodexflutter/Api_Calls/Auth_Apis.dart';
import 'package:nodexflutter/Screens/BottomTabs.dart';
import 'package:nodexflutter/Screens/SignupScreen.dart';
import 'package:nodexflutter/Utils/CustomTF.dart';
import 'package:nodexflutter/Utils/ShowSnackBar.dart';

import 'Forgot/ForgotScreen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailClt = TextEditingController();
  final TextEditingController _passClt = TextEditingController();


  @override
  void dispose() {
    _emailClt.dispose();
    _passClt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, bottom: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Sign in',
                      style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),
            ),
            CustomTF(clt: _emailClt, txt: "Email Address", obscureText: false,),
            SizedBox(
              height: size.height * .01,
            ),
            CustomTF(clt: _passClt, txt: "Password", obscureText: true,),
            SizedBox(
              height: size.height * .01,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>ForgotScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot password?'),
                ],
              ),
            ),
            SizedBox(
              height: size.height * .01,
            ),
            ElevatedButton(
              onPressed: () async{
                AuthApi authApi = AuthApi();
                UserController userController = UserController(authApi);
                userController.loginInfo(email: _emailClt.text, password: _passClt.text);
                await authApi.login(userController.loginCred).then((value)async{
                    if(value){
                      showSnackBar(context, "Login Successfully");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>BottomNavTabs()));
                    }else{
                      showSnackBar(context, "Unable to login");
                    }
                });
                
              },
              child: Text("Continue"),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Don't have account? "),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignupScreen()));
                    },
                    child: Text(
                      "Create one",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}