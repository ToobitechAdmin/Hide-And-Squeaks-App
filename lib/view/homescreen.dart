import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squeak/Local%20Storage/global_variable.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';
import 'package:gradient_slider/gradient_slider.dart';
import 'package:squeak/view/login_screen.dart';

import '../App_URL/apiurl.dart';
import '../components/colors.dart';
import '../components/custom_playbutton.dart';
import '../components/snakbar.dart';
import '../controller/audio_controller.dart';
import 'video_thum.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AudioController controller = Get.put(AudioController());

  late List<bool> isPlayingList;
  final RxInt currentAudioIndex = 0.obs;
  double _sliderValue = 0.0;
  @override
  void initState() {
    super.initState();
    controller.getAudioData();
    controller.getMylibraryData();
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

              Stack(
                children: [
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
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: Get.height * 0.022,
              ),
              Obx(() => CustonPlayButton(
                    playIcon: Icon(
                        controller.isPlaying.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 42,
                        color: AppColors.buttoncolor),
                    playTap: () async {
                      print('object123');
                      print(controller.isPlaying.value);
                      if (controller.isPlaying.value) {
                        controller.pauseAudio();
                      } else {
                        controller.playAudio(
                            '${AppUrl.audioPath + controller.audioUrlsList[0]}');
                      }
                    },
                    previousTap: () {
                      if (controller.audioUrlsList.isNotEmpty) {
                        if (currentAudioIndex.value > 0) {
                          // If there is a previous audio URL in the list, play it
                          print('Previous One');
                          currentAudioIndex.value--;
                          controller.playAudio(
                            '${AppUrl.audioPath + controller.audioUrlsList[currentAudioIndex.value]}',
                          );
                        } else {
                          print('Previous Two');
                          // If we're at the beginning of the list, loop to the end
                          currentAudioIndex.value =
                              controller.audioUrlsList.length - 1;
                          controller.playAudio(
                            '${AppUrl.audioPath + controller.audioUrlsList[currentAudioIndex.value]}',
                          );
                        }
                      } else {
                        showInSnackBar('Audio not Available',
                            color: Colors.red);
                      }
                    },
                    nextTap: () {
                      if (controller.audioUrlsList.isNotEmpty) {
                        if (currentAudioIndex.value <
                            controller.audioUrlsList.length - 1) {
                          print('Next One');
                          // If there is a next audio URL in the list, play it
                          currentAudioIndex.value++;
                          controller.playAudio(
                            '${AppUrl.audioPath + controller.audioUrlsList[currentAudioIndex.value]}',
                          );
                        } else {
                          print('Next Two');
                          // If we're at the end of the list, loop back to the beginning
                          currentAudioIndex.value = 0;
                          controller.playAudio(
                            '${AppUrl.audioPath + controller.audioUrlsList[0]}',
                          );
                        }
                      } else {
                        showInSnackBar('Audio not Available',
                            color: Colors.red);
                      }
                    },
                  )),
              // CustonPlayButton(
              //   playIcon: Icon(Icons.play_arrow_rounded,
              //       size: 42, color: AppColors.buttoncolor),
              //   playTap: () {
              //     // Get.to(VideoThumbnailScreen());
              //   },
              //   previousTap: () {},
              //   nextTap: () {},
              // ),
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
