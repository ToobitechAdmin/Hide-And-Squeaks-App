// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// class BluetoothMusicService {
//   final FlutterBlue _flutterBlue = FlutterBlue.instance;
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   BluetoothMusicService() {
//     // Initialize Bluetooth listener
//     _flutterBlue.state.listen((state) {
//       if (state == BluetoothState.connected) {
//         _playMusic();
//       } else {
//         _stopMusic();
//       }
//     });
//   }

//   void _playMusic() {
//     // Play music logic
//     // For example:
//     _audioPlayer.play(UrlSource("assets/bluetooth/"));
//   }

//   void _stopMusic() {
//     // Stop music logic
//     // For example:
//     _audioPlayer.stop();
//   }
// }