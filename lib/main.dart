import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/view/homescreen.dart';
import 'package:squeak/view/purchase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(textTheme: TextTheme()
          // Other theme configurations...
          ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
