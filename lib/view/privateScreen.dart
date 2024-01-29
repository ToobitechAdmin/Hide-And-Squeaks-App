import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/App_URL/apiurl.dart';
import 'package:squeak/Local%20Storage/global_variable.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/controller/video_controller.dart';
import 'package:squeak/models/comment_model.dart';
import 'package:squeak/models/user_model.dart';
import 'package:squeak/models/video_model.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';

import '../components/colors.dart';

class PrivateScreen extends StatefulWidget {
  final String link;
  final String title;
  
  PrivateScreen({required this.link,required this.title});

  @override
  _PrivateScreenState createState() => _PrivateScreenState();
}

class _PrivateScreenState extends State<PrivateScreen> {
  TextEditingController commentController = TextEditingController();
  VideoController controller = Get.put(VideoController());
  
  VideoPlayerController? _controller;

  bool _isPlaying = false;
  bool _displayControls = true;

  _initializeController(String videoUrl) async {
    VideoPlayerController newController =
        VideoPlayerController.network(videoUrl);

    await newController.initialize();
    newController.setLooping(true);

    newController.addListener(() {
      setState(() {
        _isPlaying = newController.value.isPlaying;
        if (_isPlaying) {
          Future.delayed(Duration(seconds: 5), () {
            if (newController.value.isPlaying) {
              setState(() => _displayControls = false);
            }
          });
        }
      });
    });

    if (mounted) {
      setState(() {
        _controller = newController;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    

    _initializeController(AppUrl.videoURL+widget.link.toString());
  }

  void _toggleControls() {
    setState(() => _displayControls = !_displayControls);
  }

  @override
  Widget build(BuildContext context) {
  
    
  
    return Scaffold(
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
                child: _controller == null
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : _controller!.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: _toggleControls,
                                  child: VideoPlayer(_controller!),
                                ),
                                _displayControls
                                    ? _ControlsOverlay(controller: _controller!)
                                    : Container(),
                                VideoProgressIndicator(
                                  _controller!,
                                  allowScrubbing: true,
                                  colors: VideoProgressColors(
                                    playedColor: AppColors.primaryColor,
                                    bufferedColor: Colors.grey,
                                    backgroundColor: Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                                height: Get.height * 0.05,
                                width: Get.width * 0.1,
                                child: CircularProgressIndicator(
                                    color: AppColors.primaryColor)),
              )) ,
              SizedBox(height: Get.height*0.02,),
           Text(widget.title.toString(),style: TextStyle(color: AppColors.primaryColor,fontSize: 30,fontWeight: FontWeight.w800),)
           
            ],
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.replay_10,
                size: 35,
              ),
              color: AppColors.primaryColor,
              onPressed: () {
                final currentPosition = controller.value.position;
                final newPosition = currentPosition - Duration(seconds: 10);
                controller.seekTo(newPosition);
              },
            ),
            GestureDetector(
              onTap: () {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
              },
              child: Icon(
                controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: AppColors.primaryColor,
                size: 75.0,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.forward_10,
                size: 35,
              ),
              color: AppColors.primaryColor,
              onPressed: () {
                final currentPosition = controller.value.position;
                final newPosition = currentPosition + Duration(seconds: 10);
                controller.seekTo(newPosition);
              },
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 200),
          child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(
                Icons.fullscreen,
                size: 40,
              ),
              color: AppColors.primaryColor,
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: VideoTimer(controller: controller),
        ),
      ],
    );
  }
}

class VideoTimer extends StatelessWidget {
  final VideoPlayerController controller;

  VideoTimer({required this.controller});

  String _formatDuration(Duration duration) {
    return "${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final position = controller.value.position;
    final duration = controller.value.duration;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _formatDuration(position),
          style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
        ),
        Text(
          _formatDuration(duration),
          style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
        ),
      ],
    );
  }
}
