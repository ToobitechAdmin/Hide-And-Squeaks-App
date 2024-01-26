// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:squeak/components/app_assets.dart';

// import 'colors.dart';

// class AudioPlayerApp extends StatefulWidget {
//   @override
//   _AudioPlayerAppState createState() => _AudioPlayerAppState();
// }

// class _AudioPlayerAppState extends State<AudioPlayerApp> {
//   late AudioPlayer _audioPlayer;
//   String _audioUrl =
//       'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';

//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//     _initAudioPlayer();
//   }

//   Future<void> _initAudioPlayer() async {
//     await _audioPlayer.setUrl(_audioUrl);
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
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     _audioPlayer.playing ? Icons.pause : Icons.play_arrow,
//                   ),
//                   onPressed: () {
//                     if (_audioPlayer.playing) {
//                       _audioPlayer.pause();
//                     } else {
//                       _audioPlayer.play();
//                     }
//                     setState(() {}); // Trigger a rebuild
//                   },
//                 ),
//                 Text('Song Title'),
//                 StreamBuilder<Duration?>(
//                   stream: _audioPlayer.durationStream,
//                   builder: (context, snapshot) {
//                     final duration = snapshot.data ?? Duration.zero;
//                     return Text('${_printDuration(duration)}');
//                   },
//                 ),
//               ],
//             ),
//             StreamBuilder<Duration>(
//               stream: _audioPlayer.positionStream,
//               builder: (context, snapshot) {
//                 final position = snapshot.data ?? Duration.zero;
//                 return LinearProgressIndicator(
//                   value: position.inSeconds.toDouble() /
//                       (_audioPlayer.duration?.inSeconds.toDouble() ?? 1),
//                   valueColor: AlwaysStoppedAnimation<Color>(
//                     AppColors.primaryColor,
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   String _printDuration(Duration duration) {
//     final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
//     final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
//     return '$minutes:$seconds';
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
// }
