import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom_appbar.dart';
import 'package:squeak/view/social_screen.dart';
import '../components/colors.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          CustomAppBar(),
          SizedBox(
            height: Get.height * 0.025,
          ),
          Container(
            height: Get.height * 0.24,
            width: Get.width * 0.83,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    image: AssetImage(AppAssets.social), fit: BoxFit.fill)),
          ),
          Expanded(
            child: Container(
              height: Get.height * 0.5,
              width: Get.width * 0.85,
              color: Colors.transparent,
              child: SocialTabScreen(),
            ),
          )
        ],
      ),
    );
  }
}
