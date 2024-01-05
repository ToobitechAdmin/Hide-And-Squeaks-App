import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squeak/components/colors.dart';
import 'package:squeak/controller/authentications.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';

import 'package:squeak/view/login_screen.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
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
                style: GoogleFonts.poppins(
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
                    controller: _emailController,
                    validator: _validateEmail,
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
                    AuthController().requestOTP(_emailController.toString());
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
