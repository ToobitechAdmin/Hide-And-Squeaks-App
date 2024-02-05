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
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        User? currentUser = _auth.currentUser;
        String userEmail = currentUser?.email ?? '';
        String userDisplayName = currentUser?.displayName ?? '';

        List<String> nameParts = userDisplayName.split(' ');
        String userFirstName = nameParts[0];
        String userLastName = nameParts.length > 1 ? nameParts[1] : '';
        print(userEmail);
        print(userFirstName);
        print(userLastName);

        String randomPassword = "toobitechsqueaks";
        print(randomPassword);

        // ignore: deprecated_member_use
        // await userCredential.user?.updateProfile(displayName: 'Google User');

        isUserRegistered() {
          if (userCredential.additionalUserInfo?.isNewUser == false) {
            print("Logincall");

            return signInUser(userEmail, randomPassword);
          } else {
            print("Registration called");

            return registerUser(
                userFirstName, userLastName, userEmail, randomPassword);
          }
        }

        isUserRegistered();
      }
    } catch (e) {
      showInSnackBar("Error While Authentcation${e}",
          color: AppColors.errorcolor);
      print(e.toString());
    }
  }

  GoogleSignOut() {
    _googleSignIn.signOut();
    _auth.signOut();
    print("Google Log Out");
  }

  facebookSignOut() {
    FacebookAuth.instance.logOut();
    _auth.signOut();
    print("Facebook Log Out");
  }

  signInWithFacebook() async {
    try {
      
      final LoginResult result = await FacebookAuth.instance.login();

     
      if (result.status == LoginStatus.success) {
        final AuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        // Sign in to Firebase with the Facebook Auth credentials
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        User? currentUser = FirebaseAuth.instance.currentUser;
        String userEmail = currentUser?.email ?? '';
        String userDisplayName = currentUser?.displayName ?? '';

        List<String> nameParts = userDisplayName.split(' ');
        String userFirstName = nameParts[0];
        String userLastName = nameParts.length > 1 ? nameParts[1] : '';
        print(userEmail);
        print(userFirstName);
        print(userLastName);

        String randomPassword = "toobitechsqueaks";
        print(randomPassword);

        // ignore: deprecated_member_use
        await userCredential.user?.updateProfile(displayName: 'Facebook User');

        isUserRegistered() {
          if (userCredential.additionalUserInfo?.isNewUser == false) {
            print("Login called");
            return signInUser(userEmail, randomPassword);
          } else {
            print("Registration called");
            return registerUser(
              userFirstName,
              userLastName,
              userEmail,
              randomPassword,
            );
          }
        }

        isUserRegistered();
      }
    } catch (e) {
      showInSnackBar("Error While Authentication $e",
          color: AppColors.errorcolor);
      print(e.toString());
    }
  }

  signInUser(String email, String password) async {
    print(email);
    print(password);
    showDialogue();
    try {
      final response = await http.post(
        Uri.parse(AppUrl.SignInURL),
        body: {
          "email": email,
          "password": password,
        },
      );
      Get.back();
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          print(responseData["data"]["name"]);
          print(responseData);

          appStorage.write(userToken, responseData['data']["token"]);
          appStorage.write("userToken", responseData['data']["token"]);
         
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

    try {
      final response = await http.post(Uri.parse(AppUrl.registerURL), headers: {
        'Accept': 'application/json',
      }, body: {
        "name": firstNameController,
        "last_name": lastNameController,
        "email": emailController,
        "password": passwordController,
      });
      Get.back();
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseData['success'] == true) {
          print("SignUp In successful");
          print("Response: ${response.body}");

          Get.offAll(LoginScreen());
        } 
      } else {
        print("Sign Up error: ${response.statusCode}");
        print("Response: ${response.body}");
        showInSnackBar(
            "Error ${response.statusCode} ${responseData['message']}",
            color: AppColors.errorcolor);
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  String receivedOtp = "";

  requestOTP(String email) async {
    print(email);
    showDialogue();

    try {
      final response = await http.post(Uri.parse(AppUrl.ForgotURL), body: {
        "email": email,
      });
      Get.back();
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseData['success'] == true) {
          print("OTP request successful");
          receivedOtp = responseData['data']['otp'].toString();
          print("Received OTP: $receivedOtp");

          Get.off(() => OtpScreen(receivedOtp: receivedOtp, userEmail: email));
        }
      } else {
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
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(enteredOtp);
      print(userEmail);

      if (response.statusCode == 200) {
        print("${response.body}");

        print('OTP verification successful');

        Get.off(() => PasswordScreen(userEmail: userEmail));
      } else {
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
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        print('Password update successful');
        showInSnackBar("Password Updated Successfully",
            color: AppColors.greencolor);

        Get.off(() => LoginScreen());
      } else {
        print(
            'Failed to update password: ${response.statusCode} ${responseData["message"]}');
      }
    } catch (error) {
      print('Error updating password: $error');
    }
  }
}
