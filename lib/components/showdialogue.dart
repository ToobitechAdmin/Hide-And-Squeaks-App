import 'package:flutter/material.dart';
import 'package:squeak/components/color.dart';
import 'package:get/get.dart';

class customDialogue{
  customDialogue._privateConstructor();
  static final customDialogue instance = customDialogue._privateConstructor();
  showDialogue(){
    Get.dialog(
      Center(
        child: CircularProgressIndicator(color: Customitems.maincolor,),
      ),
      barrierDismissible: false,
    );
  }
}
