import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:video_player/video_player.dart';

import '../components/colors.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _displayControls = true;

  void _toggleControls() {
    setState(() => _displayControls = !_displayControls);
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.setLooping(true);
    _controller.addListener(() {
      setState(() {
        _isPlaying = _controller.value.isPlaying;
        if (_isPlaying) {
          Future.delayed(Duration(seconds: 3), () {
            if (_controller.value.isPlaying) {
              setState(() => _displayControls = false);
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 0.5,
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _toggleControls,
                      child: VideoPlayer(_controller),
                    ),
                    _displayControls
                        ? _ControlsOverlay(controller: _controller)
                        : Container(),
                    VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor:
                            AppColors.primaryColor, // Customize played color
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
              ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
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
              color: Colors.white,
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
                color: Colors.white,
                size: 75.0,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.forward_10,
                size: 35,
              ),
              color: Colors.white,
              onPressed: () {
                final currentPosition = controller.value.position;
                final newPosition = currentPosition + Duration(seconds: 10);
                controller.seekTo(newPosition);
              },
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 75),
          child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(
                Icons.fullscreen,
                size: 40,
              ),
              color: Colors.white,
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
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Text(
          _formatDuration(duration),
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
