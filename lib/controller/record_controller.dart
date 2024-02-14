

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:squeak/App_URL/apiurl.dart';
import 'package:squeak/Local%20Storage/global_variable.dart';
import 'package:squeak/components/colors.dart';
import 'package:squeak/components/snakbar.dart';
import 'package:squeak/global/alertbox.dart';
import 'package:squeak/models/audio_model.dart';
import 'package:http/http.dart' as http;

class recordController extends GetxController{
  
  postVideo(AudioModel recordData) async {
   
    print(recordData.title);
    print(recordData.filePath);
    print(recordData.time);
  
   
    showDialogue();

    String currentToken = appStorage.read('userToken');

    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(AppUrl.PostVideoURL))
            ..headers['Authorization'] = 'Bearer $currentToken'
            ..headers['Accept'] = 'application/json'
            ..fields['title'] = recordData.title
            ..fields['title'] = recordData.time
            
            ..files.add(await http.MultipartFile.fromPath(
              'file_path',
              recordData.filePath,
            ));
           

      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> responseData = json.decode(responseBody);

      if (response.statusCode == 200) {
        showInSnackBar("${responseData["message"]}",
            color: AppColors.greencolor);
        Get.back();

        print(response.statusCode);
        print(responseData);
       

        {
          print(" ${responseData['message']}");
        
        }
      } else {
        print("Response: ${responseData["message"]}");
        if (responseData['success'] == false) {
          Get.back();

          print("Response: ${responseData["message"]}");
          showInSnackBar("${responseData["message"]}",
              color: AppColors.errorcolor);
        }
      }
    } catch (error) {
      Get.back();
      print("Error: $error");
    }
  }




}