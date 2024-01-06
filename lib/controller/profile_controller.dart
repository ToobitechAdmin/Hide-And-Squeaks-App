import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:squeak/App_URL/apiurl.dart';
import 'package:squeak/Local%20Storage/global_variable.dart';
import 'package:squeak/components/colors.dart';
import 'package:squeak/components/snakbar.dart';
import 'package:squeak/dumy%20Models/user_model.dart';
import 'package:squeak/global/alertbox.dart';

class ProfileController extends GetxController {
  final Rx<File?> image = Rx<File?>(null);

  void pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage == null) return;

      final imageTemp = File(pickedImage.path);

      image.value = imageTemp;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  postProfile(userModel model) async {
    showDialogue();
    String currentToken = appStorage.read('userToken');

    print('inside $currentToken');
    try {
      final response = await http.post(
        Uri.parse(AppUrl.postProfileURL),
        headers: {
          'Authorization': "Bearer  $currentToken ",
          'Accept': "application/json"
        },
        body: {
          "pet_name": model.petName,
          "pet_breed": model.petBreed,
          "profile": model.profile
        },
      );
      Get.back();
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          print(responseData["data"]);
          showInSnackBar("${responseData["message"]}",
              color: AppColors.greencolor);

          print("Response: ${response.body}");
        } else {
          print(responseData['message']);
          print(" ${responseData['message']}");
        }
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);

        print("Response: ${response.body}");
        if (responseData['success'] == false) {
          print("Response: ${responseData["message"]}");

          showInSnackBar("${responseData["message"]}",
              color: AppColors.errorcolor);
        } else {
          showInSnackBar("${responseData["message"]}",
              color: AppColors.errorcolor);
        }
      }
    } catch (error) {
      print("Error: $error");
    }
  }
// final userModel = Rx<userModel?>(null);
  getProfile() async {
    String currentToken = appStorage.read('userToken');

    print('inside $currentToken');
    try {
      final response = await http.get(
        Uri.parse(AppUrl.GetProfileURL),
        headers: {
          'Authorization': "Bearer  $currentToken ",
          'Accept': "application/json"
        },
      );

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
         print(response.body);
        final Map<String, dynamic> responseData = json.decode(response.body);
       userModel result = userModel.fromJson(responseData);
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        showInSnackBar("${responseData["message"]}",
            color: AppColors.errorcolor);
        print('GET request failed with status: ${response.statusCode}');
      
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
