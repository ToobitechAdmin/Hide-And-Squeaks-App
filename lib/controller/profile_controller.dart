import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

      if (pickedImage == null){
        
      print('No image picked.');
       return;}

      final imageTemp = File(pickedImage.path);

      image.value = imageTemp;
      print(image.value);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  //   postProfile(userModel model) async {
  //   String currentToken = appStorage.read('userToken');
  //   print('Request URL: ${AppUrl.postProfileURL}');

  //   try {
  //     var uri = Uri.parse(AppUrl.postProfileURL);
  //     var request = http.MultipartRequest("POST", uri);

  //     // Add text fields
  //     request.headers['Authorization'] = "Bearer $currentToken";
  //     request.headers['Accept'] = "application/json";

  //     request.fields['petName'] = model.petName;
  //     request.fields['petBreed'] = model.petBreed;

  //     // Add the image as a part of the request
  //     if (ProfileController().image.value != null) {
      
    
  //       request.files.add(http.MultipartFile(
  //         'profile', // Field name for the file
  //         ProfileController().image.value!.readAsBytes().asStream(),
  //         ProfileController().image.value!.lengthSync(),
          
  //         filename: (ProfileController().image.value!.path),
          
  //       ));
  //     }
  //     print(ProfileController().image.value.toString());

  //     var response = await request.send();
      
  //     if (response.statusCode == 200) {
  //        print('${response}');
       
  //       print('Profile updated successfully');
       
  //     } else {
  //       print('Failed to update profile. Status code: ${response}');
        
  //     }
  //   } catch (error) {
  //     print('Error during profile update: $error');
  //     // Handle the error if needed
  //   }
  // }

  // postProfile(userModel model) async {
  //   showDialogue();
  //   String currentToken = appStorage.read('userToken');

  //   print('inside $currentToken');
  //   try {
  //     final response = await http.post(
  //       Uri.parse(AppUrl.postProfileURL),
  //       headers: {
  //         'Authorization': "Bearer  $currentToken ",
  //         'Accept': "application/json"
  //       },
  //       body: {
  //         "pet_name": model.petName,
  //         "pet_breed": model.petBreed,
  //         "profile": model.profile
  //       },
  //     );
  //     Get.back();
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = json.decode(response.body);

  //       if (responseData['success'] == true) {
  //         print(responseData["data"]);
  //         showInSnackBar("${responseData["message"]}",
  //             color: AppColors.greencolor);

  //         print("Response: ${response.body}");
  //       } else {
  //         print(" ${responseData['message']}");
  //       }
  //     } else {
  //       final Map<String, dynamic> responseData = json.decode(response.body);

  //       print("Response: ${response.body}");
  //       if (responseData['success'] == false) {
  //         print("Response: ${responseData["message"]}");

  //         showInSnackBar("${responseData["message"]}",
  //             color: AppColors.errorcolor);
  //       } else {
  //         showInSnackBar("${responseData["message"]}",
  //             color: AppColors.errorcolor);
  //       }
  //     }
  //   } catch (error) {
  //     print("Error: $error");
  //   }
  // }
// RxList<userModel> userList = <userModel>[].obs;
//   getProfile() async {
//     String currentToken = appStorage.read('userToken');

//     print('inside $currentToken');
//     try {
//       final response = await http.get(
//         Uri.parse(AppUrl.GetProfileURL),
//         headers: {
//           'Authorization': "Bearer  $currentToken ",
//           'Accept': "application/json"
//         },
//       );

//       print(response.statusCode);
//       print(response.body);
//       if (response.statusCode == 200) {
//          print(response.body);
//         final Map<String, dynamic> responseData = json.decode(response.body);
//        userModel result = userModel.fromJson(responseData);
//        if (result.id != null) {
//           userModel.value = result;
//       } else {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         showInSnackBar("${responseData["message"]}",
//             color: AppColors.errorcolor);
//         print('GET request failed with status: ${response.statusCode}');

//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

postProfile(userModel model) async {
    showDialogue();
    String currentToken = appStorage.read('userToken');

    try {
      var request = http.MultipartRequest('POST', Uri.parse(AppUrl.postProfileURL))
        ..headers['Authorization'] = 'Bearer $currentToken'
        ..headers['Accept'] = 'application/json'
        ..fields['pet_name'] = model.petName
        ..fields['pet_breed'] = model.petBreed
        ..files.add(await http.MultipartFile.fromPath('profile', image.value!.path));

      var response = await request.send();

      Get.back();

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(await response.stream.bytesToString());

        if (responseData['success'] == true) {
          print(responseData["data"]);
          showInSnackBar("${responseData["message"]}", color: AppColors.greencolor);
          print("Response: ${responseData}");
        } else {
          print(" ${responseData['message']}");
        }
      } else {
        final Map<String, dynamic> responseData = json.decode(await response.stream.bytesToString());

        print("Response: ${responseData["message"]}");
        if (responseData['success'] == false) {
          print("Response: ${responseData["message"]}");
          showInSnackBar("${responseData["message"]}", color: AppColors.errorcolor);
        } else {
          showInSnackBar("${responseData["message"]}", color: AppColors.errorcolor);
        }
      }
    } catch (error) {
      print("Error: $error");
    }
  }
 late Rx<userModel> userData;

  // Initialize in the onInit method
  @override
  void onInit() {
    userData = userModel(petName: "", petBreed:"", profile:"").obs; 
    fetchUserData();
    super.onInit();
  }
  

  // Function to fetch user data from the API
  fetchUserData() async {
    String currentToken = appStorage.read('userToken');

    try {
      final response = await http.get(Uri.parse(AppUrl.GetProfileURL),
          headers: {
            'Authorization': "Bearer  $currentToken ",
            'Accept': "application/json"
          });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
         print(response.statusCode);
         print(response.body);
         
      
  
        final String petName = responseData['data']['pet_name'] as String? ?? 'DefaultPetName';
      final String petBreed = responseData['data']['pet_breed'] as String? ?? 'DefaultPetBreed';
      final String profile = responseData['data']['profile'] as String? ?? '';
      print("Image URL${responseData["data"]["profile"]}");
      

      
      final userModelInstance = userModel(petName: petName, petBreed: petBreed, profile: profile);
      
      
      userData(userModelInstance);
        

    
      } else {
        print('GET request failed with status: ${response.statusCode}');
       
      }
    } catch (error) {
      print('Error during GET request: $error');
      
    }
  }
}
