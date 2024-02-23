import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/colors.dart';

class CustomButton extends StatelessWidget {
  final String fieldname;

  CustomButton({required this.fieldname});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.067,
      width: Get.width * 0.9,
      color: AppColors.primaryColor,
      child: Center(
        child: Text(
          fieldname,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.whitecolor),
        ),
      ),
    );
  }
}