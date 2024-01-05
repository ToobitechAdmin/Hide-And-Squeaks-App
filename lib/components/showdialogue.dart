import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

class customDialogue {
  customDialogue._privateConstructor();
  static final customDialogue instance = customDialogue._privateConstructor();
  showDialogue() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
      barrierDismissible: false,
    );
  }
}
