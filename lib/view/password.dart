import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squeak/controller/authentications.dart';
import 'package:squeak/components/color.dart';
import 'package:squeak/components/custom.dart';

class PasswordScreen extends StatefulWidget {
  final String userEmail;

  const PasswordScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final GlobalKey<FormState> _formKey5 = GlobalKey<FormState>();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _reEnterPasswordController = TextEditingController();

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length <= 4) {
      return "Passsword Must greater than or equal to 4 ";
    }
    return null;
  }

  String? validateReEnterPassword(String? value) {
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
            image: AssetImage(Customitems.backgroundimage1),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Customitems.filterclr,
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
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w800,
                    fontSize: 35,
                    color: Customitems.whitecolor,
                  ),
                ),
                SizedBox(height: Get.height * 0.09),
                Form(
                  key: _formKey5,
                  child: Column(
                    children: [
                      CustomTextField(
                        hinttext: "Enter New Password",
                        controller: _newPasswordController,
                        validator: validateNewPassword,
                        showSuffixIcon: true,
                      ),
                      SizedBox(height: Get.height * 0.016),
                      CustomTextField(
                        hinttext: "Re-Enter Password",
                        controller: _reEnterPasswordController,
                        validator: validateReEnterPassword,
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
                      if (_newPasswordController.text ==
                          _reEnterPasswordController.text) {
                        AuthController().updatePassword(
                            widget.userEmail, _newPasswordController.text);
                      } else {
                        // Passwords don't match, show an error message or handle accordingly
                        Get.snackbar(
                          'Password Mismatch',
                          'New Password and Re-entered Password do not match',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Customitems.errorclr,
                          colorText: Customitems.whitecolor,
                        );
                      }
                    }
                  },
                  child: Container(
                    height: Get.height * 0.067,
                    width: Get.width * 0.9,
                    color: Customitems.maincolor,
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.dmSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Customitems.whitecolor,
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
