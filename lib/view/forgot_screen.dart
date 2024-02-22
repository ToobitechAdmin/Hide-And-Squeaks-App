import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:squeak/components/colors.dart';
import 'package:squeak/components/customTextField.dart';
import 'package:squeak/components/custom_auth.dart';
import 'package:squeak/controller/auth_controller.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom_appbar.dart';

import 'package:squeak/view/login_screen.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  AuthController controller = Get.put(AuthController());
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  final _emailValidator = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: Get.height * 1,
          width: Get.width * 1,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(AppAssets.backgroundimage1),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              AppColors.filtercolor, // Adjust opacity as needed
              BlendMode.srcOver,
            ),
          )),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  CustomContainer(),
                  SizedBox(height: Get.height * 0.075),
                  Text(
                    "Forgot\n Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.05,
                        fontWeight: FontWeight.w700,
                        fontSize: 35,
                        color: AppColors.whitecolor),
                  ),
                  SizedBox(height: Get.height * 0.1),
                  Form(
                      key: _formKey3,
                      child: CustomTextField(
                        hinttext: "Enter Your Email",
                        controller: emailController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          } else if (!_emailValidator.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        showSuffixIcon: false,
                      )),
                  Container(
                    height: Get.height * 0.0550,
                    width: Get.width * 0.9,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(LoginScreen());
                        },
                        child: Text(
                          "Sign in?",
                          style: TextStyle(
                              fontSize: 12, color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.07),
                  GestureDetector(
                    onTap: () {
                      if (_formKey3.currentState?.validate() ?? false) {
                        controller.requestOTP(emailController.value.text);
                      }
                    },
                    child: Container(
                      height: Get.height * 0.067,
                      width: Get.width * 0.9,
                      color: AppColors.primaryColor,
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whitecolor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.085),
                ],
              ),
            ),
          ),
        ));
  }
}
