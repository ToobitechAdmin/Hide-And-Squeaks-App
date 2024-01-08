import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/view/audio_play_screen.dart';
import 'app_assets.dart';
import 'colors.dart';

class CustonPlayButton extends StatelessWidget {
  VoidCallback? playTap;
  VoidCallback? nextTap;
  VoidCallback? previousTap;
  Icon playIcon;
  CustonPlayButton(
      {required this.playTap,
      required this.previousTap,
      required this.playIcon,
      required this.nextTap});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      backgroundImage: AssetImage(AppAssets.watch),
      radius: 145,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 3, top: 32),
            child: GestureDetector(
                onTap: () {
                  print("Bluetooth button pressed");
                  // Get.to(BluetoothAudioPlayerScreen());
                },
                child: Icon(
                  Icons.bluetooth_rounded,
                  size: 32,
                  color: AppColors.buttoncolor,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 55),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 23, top: 3),
                  child: GestureDetector(
                      onTap: previousTap,
                      child: Icon(
                        Icons.skip_previous_rounded,
                        size: 40,
                        color: AppColors.buttoncolor,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 63, top: 2.5),
                  child: GestureDetector(onTap: playTap, child: playIcon
                      // Icon(
                      //     indexPlaying ? Icons.pause : Icons.play_arrow_rounded,
                      //     size: 42,
                      //     color: AppColors.buttoncolor)
                      ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 58),
                  child: GestureDetector(
                      onTap: nextTap,
                      child: Icon(Icons.skip_next_rounded,
                          size: 40, color: AppColors.buttoncolor)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 61, left: 1),
            child: GestureDetector(
                onTap: () {
                  Get.to(AudioPlayScreen());
                },
                child: Icon(
                  Icons.format_list_bulleted,
                  size: 30,
                  color: AppColors.buttoncolor,
                  weight: 100,
                )),
          ),
        ],
      ),
    );
  }
}
