import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squeak/controller/authentications.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';

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
  List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());
  final GlobalKey<FormState> _formKey4 = GlobalKey<FormState>();
  String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a digit';
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
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              children: [
                CustomContainer(),
                SizedBox(height: Get.height * 0.1),
                Text(
                  "OTP Code",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w800,
                      fontSize: 35,
                      color: AppColors.whitecolor),
                ),
                SizedBox(height: Get.height * 0.1),
                Form(
                  key: _formKey4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (index) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            validator: validateOTP,
                            controller: otpControllers[index],
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: AppColors.whitecolor,
                            style: TextStyle(
                              color: AppColors.whitecolor,
                              fontSize: 17,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              filled: true,
                              fillColor: AppColors.textfieldcolor,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
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
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.13),
                GestureDetector(
                  onTap: () {
                    AuthController().verifyOtpAndNavigate(
                        otpControllers, widget.receivedOtp, widget.userEmail);
                  }, // Pass receivedOtp as an argument

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
