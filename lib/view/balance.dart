import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';
import 'package:squeak/controller/treat_Controller.dart';

import '../components/colors.dart';
import '../models/treatmodel.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  treatController controller =Get.put(treatController());
  @override
  void initState() {
    super.initState();
    controller.getBalance();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 1,
        width: Get.width * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.backgroundmain), fit: BoxFit.fill)),
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
                 Obx(() => controller.isLoadingbalance.value? CircularProgressIndicator(color: AppColors.primaryColor,)  :Text(
                    controller.balance.toString(),
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),),
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
                    style: TextStyle(
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
