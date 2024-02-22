// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:squeak/components/colors.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';

// class VideoCheckScreen extends StatefulWidget {
//   @override
//   _VideoCheckScreenState createState() => _VideoCheckScreenState();
// }

// class _VideoCheckScreenState extends State<VideoCheckScreen> {
//   late ChewieController _chewieController;
//   late VideoPlayerController _videoPlayerController;

//   @override
//   void initState() {
//     super.initState();
//     controller.ViewData(widget.view.id!);

//     _videoPlayerController = VideoPlayerController.network(
//      AppUrl.videoURL+widget.link.toString()
//     );

//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       autoPlay: true,
//       looping: true,
//      aspectRatio:100/100,
//       allowPlaybackSpeedChanging: true,
//       allowedScreenSleep: false,
//       autoInitialize: true,
//       showControls: true,
//       showOptions: false,
//       placeholder: Container(
//         color: Colors.black,
//       ),
//       materialProgressColors: ChewieProgressColors(
//         playedColor: AppColors.primaryColor,
//         handleColor:AppColors.whitecolor,
//         backgroundColor: Colors.grey,
//         bufferedColor: Colors.black54,
//       ),

     
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: Get.height*0.5,
//         child: Chewie(
//           controller: _chewieController,
//         ),
//       ),
//     );
//   }
