import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/App_URL/apiurl.dart';

import 'package:squeak/components/app_assets.dart';

import 'package:video_player/video_player.dart';

import '../components/colors.dart';

class PrivateScreen extends StatefulWidget {
  final String link;
  final String title;

  PrivateScreen({required this.link, required this.title});

  @override
  _PrivateScreenState createState() => _PrivateScreenState();
}

class _PrivateScreenState extends State<PrivateScreen> {
  late ChewieController _chewieController;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        // ignore: deprecated_member_use
        VideoPlayerController.network(AppUrl.videoURL + widget.link.toString());

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      aspectRatio: Get.height / Get.width,
      allowPlaybackSpeedChanging: true,
      allowedScreenSleep: false,
      autoInitialize: true,
      showControls: true,
      showOptions: true,
      placeholder: Container(
        color: Colors.black,
      ),
      materialProgressColors: ChewieProgressColors(
        playedColor: AppColors.primaryColor,
        handleColor: AppColors.whitecolor,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.black54,
      ),
      cupertinoProgressColors: ChewieProgressColors(
        bufferedColor: AppColors.primaryColor

      )
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        height: Get.height * 1,
        width: Get.width * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.backgroundmain), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: Get.height * 0.75,
                  width: Get.width * 1,
                  child: Chewie(controller: _chewieController)),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                widget.title.toString(),
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              )
            ],
          ),
        ),
      )),
    );
  }
}
