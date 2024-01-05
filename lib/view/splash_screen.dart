import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/Local%20Storage/global_variable.dart';
import 'package:squeak/view/homescreen.dart';
import 'package:squeak/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      getToken();
    });
  }

  getToken() {
    print('Token ___--->>>');

    print(appStorage.read('userToken'));
    print(userToken);
    print(appStorage.read('userToken'));
    if (appStorage.read('userToken') != null) {
      Get.to(HomeScreen());
    } else {
      Get.to(LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text('Splash'),
      ),
      body: Column(
        children: [
          Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}
