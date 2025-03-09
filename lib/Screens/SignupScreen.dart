import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nodexflutter/Screens/LoginScreen.dart';
import '../ApiControllers/UserController.dart';
import '../Api_Calls/Auth_Apis.dart';
import '../Utils/CustomTF.dart';
import 'package:http/http.dart' as http;

import '../Utils/ShowSnackBar.dart';
import 'BottomTabs.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailClt = TextEditingController();
  final TextEditingController _passClt = TextEditingController();
  final TextEditingController _usernameClt = TextEditingController();
  final TextEditingController _fullnameClt = TextEditingController();

  Future<void> signup(
      BuildContext context, String email, password, username, fullname) async {
    try {
      http.Response response = await http
          .post(Uri.parse('http://10.0.2.2:8000/api/v1/users/register'), body: {
        'username': username,
        'email': email,
        'fullname': fullname,
        'password': password
      });
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['data']);
        print('signup successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sign Up Successful"),
          ),
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => BottomNavTabs()));
      } else {
        final data = jsonDecode(response.body);
        print("Signup Failed: ${data['message']}");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Error logging in")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Network Error")),
      );
    }
  }

  @override
  void dispose() {
    _emailClt.dispose();
    _passClt.dispose();
    _fullnameClt.dispose();
    _usernameClt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Column(
              children: [
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
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Create Account',
                          style: Theme.of(context).textTheme.headlineLarge),
                    ],
                  ),
                ),
                CustomTF(
                  clt: _fullnameClt,
                  txt: "full name",
                  obscureText: false,
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                CustomTF(
                  clt: _usernameClt,
                  txt: "username",
                  obscureText: false,
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                CustomTF(
                  clt: _emailClt,
                  txt: "email",
                  obscureText: false,
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                CustomTF(
                  clt: _passClt,
                  txt: "password",
                  obscureText: true,
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                ElevatedButton(
                    onPressed: () async {
                      AuthApi authApi = AuthApi();
                      UserController userController = UserController(authApi);
                      userController.signupInfo(
                          email: _emailClt.text, password: _passClt.text, username: _usernameClt.text, fullname: _fullnameClt.text);
                      await authApi
                          .signup(userController.signupCred)
                          .then((value) async {
                        if (value) {
                          showSnackBar(context, "Signup Successfully");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LoginScreen()));
                        } else {
                          showSnackBar(context, "Unable to Signup");
                        }
                      });
                    },
                    child: Text("Continue")),
                SizedBox(
                  height: size.height * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Already have account "),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginScreen()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
