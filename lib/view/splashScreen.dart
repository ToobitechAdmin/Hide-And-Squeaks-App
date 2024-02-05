import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/Local%20Storage/global_variable.dart';
import 'package:squeak/components/colors.dart';
import 'package:squeak/components/custom.dart';
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
    Timer(Duration(seconds: 3), () {
      signedIN();
    });
  }

  signedIN() {
   
    print(appStorage.read("userToken"));

    if (appStorage.read("userToken") != null) {
      return Get.to(HomeScreen());
    } else {
      return Get.to(LoginScreen());

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CustomContainer(),
        Center(
            child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ))
      ]),
    );
  }
}
