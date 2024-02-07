import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/controller/auth_controller.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';

import '../components/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthController controller = Get.put(AuthController());

  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _signUpPasswordController = TextEditingController();

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter FirstName';
    }
    // You can add more complex email validation logic here if needed
    return null; // Return null if the input is valid
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter LastName';
    }
    // You can add more complex password validation logic here if needed
    return null; // Return null if the input is valid
  }

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
          AppColors.filtercolor, // Adjust opacity as needed
          BlendMode.srcOver,
        ),
      )),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              CustomContainer(),
              SizedBox(height: Get.height * 0.057),
              Text(
                "Sign Up",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 35,
                    color: AppColors.whitecolor),
              ),
              SizedBox(height: Get.height * 0.060),
              Form(
                key: _formKey2,
                child: Column(
                  children: [
                    CustomTextField(
                      hinttext: "First Name",
                      controller: _firstNameController,
                      validator: validateFirstName,
                      showSuffixIcon: false,
                    ),
                    SizedBox(height: Get.height * 0.016),
                    CustomTextField(
                      hinttext: "Last Name",
                      controller: _lastNameController,
                      validator: validateLastName,
                      showSuffixIcon: false,
                    ),
                    SizedBox(height: Get.height * 0.016),
                    CustomTextField(
                        hinttext: "E-mail",
                        controller: _emailController,
                        validator: _validateEmail,
                        showSuffixIcon: false),
                    SizedBox(height: Get.height * 0.016),
                    CustomTextField(
                      hinttext: "Password",
                      controller: _signUpPasswordController,
                      validator: validatePassword,
                      showSuffixIcon: true,
                    ),
                    SizedBox(height: Get.height * 0.048),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey2.currentState?.validate() ?? false) {
                    controller.registerUser(
                      _firstNameController.text,
                      _lastNameController.text,
                      _emailController.text,
                      _signUpPasswordController.text,
                    );
                  }
                },
                child: CustomButton(fieldname: "Sign Up"),
              ),
              SizedBox(height: Get.height * 0.07),
              Text("Sign In With",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor)),
              SizedBox(height: Get.height * 0.012),
              Container(
                height: Get.height * 0.06,
                width: Get.width * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomAuth(
                        assetpath: AppAssets.facebook,
                        onTap: () {
                          controller.signInWithFacebook();
                        }),
                    SizedBox(
                      width: Get.width * 0.045,
                    ),
                    CustomAuth(assetpath: AppAssets.apple, onTap: () {}),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    CustomAuth(
                        assetpath: AppAssets.google,
                        onTap: () {
                          controller.signInWithGoogle();
                        })
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
