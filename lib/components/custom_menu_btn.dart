import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/colors.dart';

class CustomMenuBtn extends StatelessWidget {
  final String library;
  final String settingimage;

  CustomMenuBtn({required this.library, required this.settingimage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(settingimage),
            radius: 50,
            backgroundColor: Colors.transparent,
          ),
          SizedBox(height: Get.height * 0.012),
          Text(
            library,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                height: 1,
                color: AppColors.whitecolor,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}