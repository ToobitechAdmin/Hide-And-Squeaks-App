import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squeak/Local%20Storage/global_variable.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';
import 'package:gradient_slider/gradient_slider.dart';
import 'package:squeak/view/login_screen.dart';

import '../components/colors.dart';
import '../components/custom_playbutton.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _sliderValue = 0.0;
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
              SizedBox(height: Get.height * 0.025),

              Container(
                height: Get.height * 0.34,
                width: Get.width * 0.85,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppAssets.dog), fit: BoxFit.fill)),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.25, left: 1.7),
                    child: CircleAvatar(
                      radius: 119.99,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.022),
              Text(
                "Volume",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    color: AppColors.whitecolor),
              ),
              SizedBox(height: Get.height * 0.009),
              // ...

              Container(
                width: Get.width * 0.65,
                height: Get.height * 0.021,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.slider),
                    fit: BoxFit.fill,
                  ),
                ),
                child: GradientSlider(
                  thumbAsset: "assets/images/button.png",
                  thumbHeight: 36,
                  thumbWidth: 25,
                  inactiveTrackColor: Colors.transparent,
                  trackHeight: Get.height * 0.007,
                  activeTrackGradient: const LinearGradient(
                    colors: [Color(0xff804D34), Color(0xffF1DF88)],
                  ),
                  slider: Slider(
                    value: _sliderValue,
                    min: 0.0,
                    max: 100.0,
                    onChanged: (double value) {
                      setState(() {
                        _sliderValue = value;
                        // VolumeWatcher.setVolume(value);
                      });
                    },
                  ),
                ),
              ),

              SizedBox(
                height: Get.height * 0.022,
              ),
              CustonPlayButton(
                playIcon: Icon(Icons.play_arrow_rounded,
                    size: 42, color: AppColors.buttoncolor),
                playTap: () {},
                previousTap: () {},
                nextTap: () {},
              ),
              SizedBox(height: Get.height * 0.02),

              GestureDetector(
                  onTap: () {
                    appStorage.erase();
                    Get.off(LoginScreen());
                  },
                  child: CustomButton(fieldname: "Sign Out"))
            ],
          ),
        ),
      ),
    );
  }
}
