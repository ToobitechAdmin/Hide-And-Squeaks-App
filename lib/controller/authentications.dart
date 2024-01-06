import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:squeak/App_URL/apiurl.dart';
import 'package:squeak/Local%20Storage/global_variable.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/snakbar.dart';

import 'package:squeak/global/alertbox.dart';
import 'package:squeak/view/OTP.dart';
import 'package:squeak/view/homescreen.dart';
import 'package:squeak/view/password.dart';
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

          Get.off(HomeScreen());
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

          // Get.snackbar(
          //   'Sign In Failed',
          //   "${responseData['message']}",
          //   snackPosition: SnackPosition.TOP,
          //   backgroundColor: AppColors.errorclr,
          //   colorText: AppColors.whitecolor,
          // );
          showInSnackBar("${responseData["message"]}",
              color: AppColors.errorcolor);
        } else {
          // Get.snackbar(
          //   'Sign In Failed',
          //   "Error: ${response.statusCode}  ${response.body}",
          //   snackPosition: SnackPosition.TOP,
          //   backgroundColor: AppColors.errorclr,
          //   colorText: AppColors.whitecolor,
          // );

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
    Map<String, dynamic> data = {
      "name": firstNameController,
      "last_name": lastNameController,
      "email": emailController,
      "password": passwordController,
    };

    try {
      final response = await http.post(
        Uri.parse(AppUrl.registerURL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
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
          // You might want to store user data, handle tokens, etc.
        } else {
          // Login failed, handle the error message
          print("Sign Up failed: ${responseData['message']}");
        }
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);

        print("Sign Up error: ${response.statusCode}");
        print("Response: ${response.body}");
        showInSnackBar(
            "Error ${response.statusCode} ${responseData['message']}",
            color: AppColors.errorcolor);
        // Error in sign in
      }
    } catch (error) {
      // Handle exceptions
      print("Error: $error");
    }
  }

//OTP Request Sent
  String receivedOtp = ""; // Declare receivedOtp as a global variable

  Future<void> requestOTP(String email) async {
    showDialogue();

    Map<String, dynamic> data = {
      "email": email,
    };

    try {
      final response = await http.post(
        Uri.parse(AppUrl.ForgotURL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      Get.back();

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          print("OTP request successful");
          receivedOtp = responseData['data']['otp']
              .toString(); // Update receivedOtp value
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
      // Show an error message or handle the case where the OTP field is empty
      // Get.snackbar(
      //   'Error',
      //   'Please fill in all OTP fields',
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );

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
        // The API should return a success message or handle errors appropriately
        print('OTP verification successful');

        // Navigate to the next screen (e.g., PasswordScreen) and pass userEmail as an argument
        Get.off(() => PasswordScreen(userEmail: userEmail));
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("${response.body}");
        print('Failed to verify OTP: ${response.statusCode}');
        // Get.snackbar(
        //   'OTP Error',
        //   "Error ${response.statusCode} ${responseData['message']}",
        //   snackPosition: SnackPosition.TOP,
        //   backgroundColor: AppColors.errorclr,
        //   colorText: AppColors.whitecolor,
        // );
        showInSnackBar(
            "Error ${response.statusCode} ${responseData['message']}",
            color: AppColors.errorcolor);
        // Handle the error accordingly
      }
    } catch (error) {
      print('Error verifying OTP: $error');
      // Handle the error accordingly
    }
  }

  Future<void> updatePassword(String email, String password) async {
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
        // Navigate to the next screen or handle success accordingly
        Get.off(() => HomeScreen());
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(
            'Failed to update password: ${response.statusCode} ${responseData["message"]}');
        // Handle the error accordingly
      }
    } catch (error) {
      print('Error updating password: $error');
      // Handle the error accordingly
    }
  }
}
