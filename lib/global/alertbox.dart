import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/colors.dart';

showDialogue() {
  Get.dialog(
    Center(
      child: CircularProgressIndicator(color: AppColors.primaryColor),
    ),
    barrierDismissible: false,
  );
}
showProgress() {
  return(
    Center(
      child: CircularProgressIndicator(color: AppColors.primaryColor),
    ),
    barrierDismissible: false,
  );
}
