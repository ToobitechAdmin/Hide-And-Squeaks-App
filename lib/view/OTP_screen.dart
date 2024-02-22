import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/custom_auth.dart';
import 'package:squeak/components/snakbar.dart';

import '../controller/auth_controller.dart';
import 'package:squeak/components/app_assets.dart';

import '../components/colors.dart';

class OtpScreen extends StatefulWidget {
  final String receivedOtp;
  final String userEmail;

  const OtpScreen(
      {Key? key, required this.receivedOtp, required this.userEmail})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  AuthController controller = Get.put(AuthController());
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

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
        )),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              children: [
                CustomContainer(),
                SizedBox(height: Get.height * 0.1),
                Text(
                  "OTP Code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 35,
                      color: AppColors.whitecolor),
                ),
                SizedBox(height: Get.height * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          controller: otpControllers[index],
                          focusNode: focusNodes[index],
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          cursorColor: AppColors.whitecolor,
                          style: TextStyle(
                            color: AppColors.whitecolor,
                            fontSize: 17,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            filled: true,
                            fillColor: AppColors.textfieldcolor,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusColor: Colors.transparent,
                            hintStyle: TextStyle(
                              fontSize: 17,
                              color: AppColors.whitecolor,
                              fontWeight: FontWeight.w400,
                            ),
                            constraints: BoxConstraints.tightFor(
                                width: Get.width * 0.15),
                          ),
                          onChanged: (value) {
                            if (value.length == 1) {
                              if (index < 3) {
                                FocusScope.of(context)
                                    .requestFocus(focusNodes[index + 1]);
                              } else {
                                FocusScope.of(context).unfocus();
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.13),
                GestureDetector(
                  onTap: () {
                    if (otpControllers
                        .any((controller) => controller.text.isEmpty)) {
                      showInSnackBar("Please Fill all OTP Fields",
                          color: AppColors.errorcolor);
                      return;
                    } else {
                      controller.verifyOtpAndNavigate(
                          otpControllers, widget.receivedOtp, widget.userEmail);
                    }
                  },
                  child: Container(
                    height: Get.height * 0.067,
                    width: Get.width * 0.87,
                    color: AppColors.primaryColor,
                    child: Center(
                      child: Text(
                        "Verify",
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
      ),
    );
  }
}