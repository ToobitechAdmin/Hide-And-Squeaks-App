import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/Local%20Storage/global_variable.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/view/homescreen.dart';
import 'package:squeak/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 10), () {
      signedIN();
    });
  }

  signedIN() {
    print(appStorage.read("userToken"));

    if (appStorage.read("userToken") != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
      // return Get.to(LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: Get.height * 1,
          width: Get.width * 1,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAssets.splashScreen),
                  fit: BoxFit.cover)),
        ));
  }
}
