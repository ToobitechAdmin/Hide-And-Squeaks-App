import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';

import '../components/colors.dart';
import '../models/treatmodel.dart';

class TreatScreen6 extends StatefulWidget {
  
  const TreatScreen6({super.key});

  @override
  State<TreatScreen6> createState() => _TreatScreen6State();
}

class _TreatScreen6State extends State<TreatScreen6> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 1,
        width: Get.width * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.backgroundmain),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Customhead(),
              SizedBox(height: Get.height * 0.080),
              Text(
                "Balance",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              SizedBox(height: Get.height * 0.060),
              CircleAvatar(
                radius: 77,
                child: Image.asset(AppAssets.treats),
              ),
              SizedBox(height: Get.height * 0.016),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                   "20",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Treats",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ),
                  )
                ],
              ),
              SizedBox(height: Get.height * 0.15),
              Container(
                height: Get.height * 0.095,
                width: Get.width * 0.92,
                decoration: BoxDecoration(
                    color: AppColors.pinkcolor,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Song title",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryColor,
                          letterSpacing: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "50 Treats",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff77838F),
                            letterSpacing: 1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.035),
              Container(
                height: Get.height * 0.06,
                width: Get.width * 0.92,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    "Confirm",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
