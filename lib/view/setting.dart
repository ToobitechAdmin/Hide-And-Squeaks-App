import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/view/menu.dart';
import 'package:squeak/view/profile.dart';

import '../components/colors.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 1,
        width: Get.width * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.bluetoothbackground),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Get.height * 0.069,
                    width: Get.width * 0.15,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                            image: AssetImage(AppAssets.heart),
                            fit: BoxFit.fill)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(MenuScreen());
                    },
                    child: Container(
                        height: Get.height * 0.08,
                        width: Get.width * 0.12,
                        child: Icon(
                          Icons.menu_rounded,
                          color: AppColors.primaryColor,
                          size: 50,
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              "Settings",
              style: TextStyle(
                  fontSize: 37,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffDEA549)),
            ),
            SizedBox(
              height: Get.height * 0.28,
            ),
            Container(
              height: Get.height * 0.09,
              width: Get.width * 0.7,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: AppColors.whitecolor))),
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.055,
                    width: Get.width * 0.12,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppAssets.bluetooth),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  Text(
                    "Bluetooth",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whitecolor),
                  )
                ],
              ),
            ),
            Container(
              height: Get.height * 0.09,
              width: Get.width * 0.7,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: AppColors.whitecolor))),
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.055,
                    width: Get.width * 0.14,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppAssets.wifi),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  Text(
                    "Legal",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whitecolor),
                  )
                ],
              ),
            ),
            Container(
              height: Get.height * 0.09,
              width: Get.width * 0.7,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: AppColors.whitecolor))),
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.055,
                    width: Get.width * 0.12,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppAssets.bluetoothlast),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(ProfileScreen());
                    },
                    child: Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whitecolor),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
