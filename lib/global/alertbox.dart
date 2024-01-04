

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/color.dart';

showDialogue(){
  Get.dialog(
    Center(
      child: CircularProgressIndicator(color: Customitems.maincolor),
    ),
    barrierDismissible: false,
  );}