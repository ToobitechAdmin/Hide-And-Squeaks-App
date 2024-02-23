import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/app_assets.dart';

class CustomAuth extends StatelessWidget {
  final String assetpath;
  final VoidCallback onTap;

  const CustomAuth({super.key, required this.assetpath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 23,
        backgroundImage: AssetImage(assetpath),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 55),
      child: Container(
        height: Get.height * 0.117,
        width: Get.width * 0.39,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.signin), fit: BoxFit.fill)),
      ),
    );
  }
}