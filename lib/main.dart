import 'package:flutter/material.dart';
import 'package:nodexflutter/Provider_Global/BottomProvider.dart';
import 'package:nodexflutter/Screens/LoginScreen.dart';
import 'package:nodexflutter/Utils/ThemeDataClass.dart';
import 'package:provider/provider.dart';

import 'LocalStorage/SecureStorage.dart';

void main() async {
  // await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  // SecureStorage storage = SecureStorage();
  //
  // await storage.saveData('testKey', 'Hello Secure Storage');
  // String? testValue = await storage.readData('testKey');
  //
  // print('Secure Storage Test Value: $testValue');
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => BottomProvider())
      ],child: MyApp(),));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: clotTheme,
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
