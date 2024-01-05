import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:squeak/Local%20Storage/global_variable.dart';
import 'package:squeak/auth/authentications.dart';
import 'package:squeak/components/color.dart';
import 'package:squeak/view/homescreen.dart';
import 'package:squeak/view/purchase.dart';
import 'package:squeak/view/signin.dart';
import 'package:squeak/view/splashScreen.dart';









void main() async {

  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   @override
  
  

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
        )
      
      ),
      debugShowCheckedModeBanner:false,
      home:SplashScreen(),

    );
  }
}


