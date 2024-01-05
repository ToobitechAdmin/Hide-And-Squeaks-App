import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/controller/authentications.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';
import 'package:squeak/view/forgot.dart';

import 'package:squeak/view/register_screen.dart';

import '../components/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isChecked = false;

  final _emailValidator = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!_emailValidator.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length <= 4) {
      return "Passsword Must greater than or equal to 4 ";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: Get.height * 1,
      width: Get.width * 1,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(AppAssets.backgroundimage1),
        fit: BoxFit.fill,
        colorFilter: ColorFilter.mode(
          AppColors.filterclr, // Adjust opacity as needed
          BlendMode.srcOver,
        ),
      )),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomContainer(),
              SizedBox(height: Get.height * 0.075),
              Text(
                "Sign In",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 35,
                    color: AppColors.whitecolor),
              ),
              SizedBox(height: Get.height * 0.09),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hinttext: "Enter Email",
                      controller: emailController,
                      validator: _validateEmail,
                      showSuffixIcon: false,
                    ),
                    SizedBox(height: Get.height * 0.016),
                    CustomTextField(
                      hinttext: "Enter Password",
                      controller: passwordController,
                      validator: validatePassword,
                      showSuffixIcon: true,
                    )
                  ],
                ),
              ),
              Container(
                height: Get.height * 0.060,
                width: Get.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Row(
                    //   children: [
                    //     Container(
                    //       height: Get.height * 0.03,
                    //       width: Get.width * 0.062,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           color: Customitems.whitecolor,
                    //           width: 1,
                    //         ),
                    //         borderRadius: BorderRadius.circular(3),
                    //       ),
                    //       child: InkWell(
                    //         onTap: () {
                    //           setState(() {
                    //             isChecked = !isChecked;
                    //           });
                    //         },
                    //         child: Center(
                    //           child: isChecked
                    //               ? Icon(
                    //                   Icons.check,
                    //                   color: Customitems
                    //                       .whitecolor, // Set checkmark color to transparent
                    //                 )
                    //               : SizedBox
                    //                   .shrink(), // Empty space when not checked
                    //         ),
                    //       ),
                    //     ),
                    //     // Padding(
                    //     //   padding: EdgeInsets.only(left: 10),
                    //     //   child: Text(
                    //     //     "Remember me",
                    //     //     style: TextStyle(
                    //     //         fontSize: 12, color: Customitems.whitecolor),
                    //     //   ),
                    //     // )
                    //   ],
                    // ),

                    GestureDetector(
                      onTap: () {
                        Get.to(ForgotScreen());
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.primaryColor),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.05),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    AuthController().signInUser(
                        emailController.text, passwordController.text);
                  }
                },
                child: CustomButton(fieldname: "Sign In"),
              ),
              SizedBox(height: Get.height * 0.085),
              GestureDetector(
                onTap: () {
                  Get.to(RegisterScreen());
                },
                child: Container(
                  height: Get.height * 0.022,
                  width: Get.width * 0.87,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You don’t have an account?",
                          style: TextStyle(
                              fontSize: 12, color: AppColors.whitecolor),
                        ),
                        Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.015),
              Container(
                height: Get.height * 0.06,
                width: Get.width * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomAuth(assetpath: AppAssets.facebook, onTap: () {}),
                    SizedBox(
                      width: Get.width * 0.045,
                    ),
                    CustomAuth(assetpath: AppAssets.apple, onTap: () {}),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    CustomAuth(assetpath: AppAssets.google, onTap: () {})
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
