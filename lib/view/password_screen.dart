import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/customTextField.dart';
import 'package:squeak/components/custom_auth.dart';
import 'package:squeak/components/snakbar.dart';

import 'package:squeak/controller/auth_controller.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom_appbar.dart';

import '../components/colors.dart';

class PasswordScreen extends StatefulWidget {
  final String userEmail;

  const PasswordScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  AuthController controller = Get.put(AuthController());
  final GlobalKey<FormState> _formKey5 = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();

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
              AppColors.filtercolor,
              BlendMode.srcOver,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                CustomContainer(),
                SizedBox(height: Get.height * 0.075),
                Text(
                  "New Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 35,
                    color: AppColors.whitecolor,
                  ),
                ),
                SizedBox(height: Get.height * 0.09),
                Form(
                  key: _formKey5,
                  child: Column(
                    children: [
                      CustomTextField(
                        hinttext: "Enter New Password",
                        controller: newPasswordController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length <= 4) {
                            return "Passsword Must greater than or equal to 4 ";
                          }
                          return null;
                        },
                        showSuffixIcon: true,
                      ),
                      SizedBox(height: Get.height * 0.016),
                      CustomTextField(
                        hinttext: "Re-Enter Password",
                        controller: reEnterPasswordController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length <= 4) {
                            return "Passsword Must greater than or equal to 4 ";
                          }
                          return null;
                        },
                        showSuffixIcon: true,
                      )
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.006),
                SizedBox(height: Get.height * 0.11),
                GestureDetector(
                  onTap: () {
                    if (_formKey5.currentState?.validate() ?? false) {
                      if (newPasswordController.text ==
                          reEnterPasswordController.text) {
                        controller.updatePassword(
                            widget.userEmail, newPasswordController.text);
                      } else {
                        showInSnackBar(
                            'Password Mismatch New Password and Re-entered Password do not match',
                            color: AppColors.errorcolor);
                      }
                    }
                  },
                  child: Container(
                    height: Get.height * 0.067,
                    width: Get.width * 0.9,
                    color: AppColors.primaryColor,
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.whitecolor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.085),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
