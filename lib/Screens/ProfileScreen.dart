import 'package:flutter/material.dart';
import 'package:nodexflutter/Api_Calls/Auth_Apis.dart';
import 'package:nodexflutter/Utils/ShowSnackBar.dart';
import 'LoginScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {
            final authApi = AuthApi();
            await authApi.logout().then((value)=>{
              if(value){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen())),
                showSnackBar(context, 'Logout Successfully'),
              }else{
                showSnackBar(context, 'Logout failed !!'),
              }
            });
          }, icon: Icon(Icons.logout_rounded))
        ],
      ),
    );
  }
}
