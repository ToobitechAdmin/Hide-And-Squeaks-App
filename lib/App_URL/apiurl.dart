import 'package:flutter/material.dart';


class ApiUrl{

  static String base="https://digimaestros.com/dev/";
  static String SignInURL="${base}Hide-Squeaks/api/login";
  static String registerURL="${base}Hide-Squeaks/api/register";
  static String ForgotURL="${base}Hide-Squeaks/api/request-otp";
  static String OtpURL="${base}Hide-Squeaks/api/verify-otp";
  static String passwordURL="${base}Hide-Squeaks/api/reset-password";
  static String postProfileURL="http://localhost:8000/api/profile-upload";
  static String GetProfileURL="http://localhost:8000/api/profile";
}