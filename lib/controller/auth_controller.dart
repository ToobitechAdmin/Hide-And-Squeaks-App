import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:squeak/App_URL/apiurl.dart';
import 'package:squeak/Local%20Storage/global_variable.dart';

import 'package:squeak/components/snakbar.dart';

import 'package:squeak/global/alertbox.dart';
import 'package:squeak/view/OTP.dart';
import 'package:squeak/view/homescreen.dart';
import 'package:squeak/view/password_screen.dart';
import 'package:squeak/view/login_screen.dart';

import '../components/colors.dart';

class AuthController extends GetxController {
  signInUser(String emailController, String passwordController) async {
    showDialogue();
    try {
      final response = await http.post(
        Uri.parse(AppUrl.SignInURL),
        body: {
          "email": emailController,
          "password": passwordController,
        },
      );
      Get.back();
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          print(responseData["data"]);

          appStorage.write(userToken, responseData['data']["token"]);
          appStorage.write("userToken", responseData['data']["token"]);
          print('Token ___--->>>');
          print(userToken);
          print(appStorage.read('userToken'));
          print("Response: ${response.body}");

          Get.offAll(HomeScreen());
        } else {
          print(responseData['message']);
          print("Sign In failed: ${responseData['message']}");
        }
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("Sign In error: ${response.statusCode}");
        print("Response: ${response.body}");
        print(responseData["token"]);
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

//SignUp/Registration
  registerUser(String firstNameController, String lastNameController,
      String emailController, String passwordController) async {
    print(emailController);
    showDialogue();
    // Replace this with the actual user input

    try {
      final response = await http.post(Uri.parse(AppUrl.registerURL), headers: {
        'Content-Type': 'application/json',
      }, body: {
        "name": firstNameController,
        "last_name": lastNameController,
        "email": emailController,
        "password": passwordController,
      });
      Get.back();

      if (response.statusCode == 200) {
        // Parse the response JSON
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Check if login is successful
        if (responseData['success'] == true) {
          print("SignUp In successful");
          print("Response: ${response.body}");
          // Navigate to the home screen
          Get.offAll(LoginScreen());
        } else {
          print("Sign Up failed: ${responseData['message']}");
        }
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);

        print("Sign Up error: ${response.statusCode}");
        print("Response: ${response.body}");
        showInSnackBar(
            "Error ${response.statusCode} ${responseData['message']}",
            color: AppColors.errorcolor);
      }
    } catch (error) {
      // Handle exceptions
      print("Error: $error");
    }
  }

//OTP Request Sent
  String receivedOtp = ""; // Declare receivedOtp as a global variable

  requestOTP(String email) async {
    print(email);
    showDialogue();

  
      
    

    try {
      final response = await http.post(
        Uri.parse(AppUrl.ForgotURL),
        // headers: {
        //   'Accept': 'application/json',
        // },
        body: {"email": email,}
      );
      Get.back();
     

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          print("OTP request successful");
          receivedOtp = responseData['data']['otp'].toString();
          print("Received OTP: $receivedOtp");

          // Navigate to the OTP screen
          Get.off(() => OtpScreen(receivedOtp: receivedOtp, userEmail: email));
        } else {
          final Map<String, dynamic> responseData = json.decode(response.body);
          print("Sign In error: ${response.statusCode}");
          print("Response: ${response.body}");
        }
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("OTP request error: ${response.statusCode}");
        print("Response: ${response.body}");
        showInSnackBar(
            "Error ${response.statusCode} ${responseData['message']}",
            color: AppColors.errorcolor);
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  void verifyOtpAndNavigate(List<TextEditingController> otpControllers,
      String receivedOtp, String userEmail) async {
    if (otpControllers.any((controller) => controller.text.isEmpty)) {
      

      showInSnackBar("Error:Please Fill all OTP Fields");
      return;
    }

    String enteredOtp =
        otpControllers.map((controller) => controller.text).join();
    showDialogue();
    try {
      final response = await http.post(Uri.parse(AppUrl.OtpURL), body: {
        'otp': enteredOtp,
        'email': userEmail,
      });
      Get.back();
      print(enteredOtp);
      print(userEmail);

      if (response.statusCode == 200) {
        print("${response.body}");
       
        print('OTP verification successful');

        
        Get.off(() => PasswordScreen(userEmail: userEmail));
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("${response.body}");
        print('Failed to verify OTP: ${response.statusCode}');
        
        showInSnackBar(
            "Error ${response.statusCode} ${responseData['message']}",
            color: AppColors.errorcolor);
       
      }
    } catch (error) {
      print('Error verifying OTP: $error');
   
    }
  }

  updatePassword(String email, String password) async {
    showDialogue();

    try {
      final response = await http.post(Uri.parse(AppUrl.passwordURL), body: {
        'email': email,
        'password': password,
      });
      Get.back();

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Password update successful');
        showInSnackBar("Password Updated Successfully",
            color: AppColors.greencolor);

        Get.off(() => LoginScreen());
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(
            'Failed to update password: ${response.statusCode} ${responseData["message"]}');
       
      }
    } catch (error) {
      print('Error updating password: $error');
     
    }
  }
}
