// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:file_picker/file_picker.dart';

// class LoveAudioScreen extends StatefulWidget {
//   @override
//   _LoveAudioScreenState createState() => _LoveAudioScreenState();
// }

// class _LoveAudioScreenState extends State<LoveAudioScreen> {
//   late AudioPlayer player;
//   Duration position = Duration.zero;
//   Duration duration = Duration.zero;
//   String? filePath;
//    String? fileName;

//   @override
//   void initState() {
//     super.initState();
//     player = AudioPlayer();
//     // Listen to the current position updates
//     player.positionStream.listen((newPosition) {
//       setState(() {
//         position = newPosition;
//       });
//     });
//     // Listen to the total duration updates
//     player.durationStream.listen((newDuration) {
//       if (newDuration != null) {
//         setState(() {
//           duration = newDuration;
//         });
//       }
//     });
//     // Listen to the player state updates
//     player.playerStateStream.listen((playerState) {
//       if (playerState.processingState == ProcessingState.completed) {
//         setState(() {
//           // Reset the position to zero when audio completes
//           position = Duration.zero;
//         });
//       }
//       // Update the UI when player state changes
//       setState(() {});
//     });
//   }

//   Future<void> pickAudio() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
//     if (result != null) {
//       File file = File(result.files.single.path!);
//       filePath = file.path;
//        fileName = file.path.split('/').last.split('.').first; // Update the file path when a new audio is picked
//       await player.setFilePath(filePath!);
//       setState(() {
//         position = Duration.zero; // Reset the slider position when a new audio is picked
//       });
//     }
//   }

//   void playPauseAudio() {
//     if (filePath == null) {
//       // If no audio file has been selected, show a SnackBar
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please select an audio to play'),
//           duration: Duration(seconds: 3),
//         ),
//       );
//       return; // Exit the function if no audio file has been selected
//     }
//     if (player.playing) {
//       player.pause();
//     } else {
//       player.play();
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Audio Player'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: pickAudio,
//               child: Text('Pick Audio'),
//             ),
//             if (fileName != null) Text(fileName!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Slider(
//               min: 0.0,
//               max: duration.inSeconds.toDouble(),
//               value: position.inSeconds.toDouble(),
//               onChanged: (value) {
//                 setState(() {
//                   player.seek(Duration(seconds: value.toInt()));
//                 });
//               },
//             ),
//             Text("${position.inMinutes}:${position.inSeconds.remainder(60).toString().padLeft(2, '0')} / ${duration.inMinutes}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}"),
            
//             IconButton(
//               icon: Icon(player.playing ? Icons.pause : Icons.play_arrow),
//               iconSize: 48.0,
//               onPressed: playPauseAudio,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     player.dispose();
//     super.dispose();
//   }
// }







// // class loveAudioScreen extends StatefulWidget {
// //   @override
// //   _loveAudioScreenState createState() => _loveAudioScreenState();
// // }

// // class _loveAudioScreenState extends State<loveAudioScreen> {
// //   late AudioPlayer player;

// //   @override
// //   void initState() {
// //     super.initState();
// //     player = AudioPlayer();
// //   }

// //   Future<void> pickAndPlayFile() async {
// //     FilePickerResult? result = await FilePicker.platform.pickFiles(
// //       type: FileType.audio,
// //     );

// //     if (result != null) {
// //       File file = File(result.files.single.path!);
// //       await player.setFilePath(file.path);
// //       player.play();
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Pick and Play Audio'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             ElevatedButton(
// //               onPressed: pickAndPlayFile,
// //               child: Text('Pick and Play Audio'),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 player.pause();
// //               },
// //               child: Text('Pause'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     player.dispose();
// //     super.dispose();
// //   }
// // }