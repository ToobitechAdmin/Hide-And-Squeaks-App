import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';
import 'package:squeak/view/appstore.dart';
import 'package:squeak/view/profile.dart';
import 'package:squeak/view/setting.dart';
import 'package:squeak/view/socialfeed.dart';
import 'package:squeak/view/text.dart';
import 'package:squeak/view/upload.dart';
import '../components/colors.dart';
import 'audio_play_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 1,
        width: Get.width * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(AppAssets.menuback),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            AppColors.filterclr, // Adjust opacity as needed
            BlendMode.srcOver,
          ),
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Customhead(),
              SizedBox(
                height: Get.height * 0.057,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.to(AudioPlayScreen());
                            },
                            child: CustomSettings(
                                library: "Sound\nLibrary",
                                settingimage: AppAssets.settings1)),
                        GestureDetector(
                            onTap: () {
                              Get.to(UploadScreen());
                            },
                            child: CustomSettings(
                                library: "Video\nUpload",
                                settingimage: AppAssets.settings2)),
                        GestureDetector(
                            onTap: () {
                              Get.to(AppStoreScreen());
                            },
                            child: CustomSettings(
                                library: "In-App\nStore",
                                settingimage: AppAssets.settings3)),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.040,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.to(ProfileScreen());
                            },
                            child: CustomSettings(
                                library: "Profile\nSetup",
                                settingimage: AppAssets.settings4)),
                        GestureDetector(
                            onTap: () {
                              Get.to(SocialScreen());
                            },
                            child: CustomSettings(
                                library: "Social\nFeed",
                                settingimage: AppAssets.settings5)),
                        GestureDetector(
                            onTap: () {
                              Get.to(TextScreen());
                            },
                            child: CustomSettings(
                                library: "Safety\nInformation",
                                settingimage: AppAssets.settings6)),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.040,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.to(SettingScreen());
                        },
                        child: CustomSettings(
                            library: "Settings",
                            settingimage: AppAssets.settings7)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
