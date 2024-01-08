import 'dart:convert';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:squeak/dumy%20Models/audio_model.dart';
import '../App_URL/apiurl.dart';
import '../Local Storage/global_variable.dart';
import '../components/snakbar.dart';
import '../global/alertbox.dart';

class AudioController extends GetxController {
  List<AudioModel> audioSoundList = [];

  List<String> audioUrlsList = [];
  List<AudioModel> getMyLibraryList = [];
  var isLoading = false.obs;
  var audioisLoading = false.obs;
  final AudioPlayer audioPlayer = AudioPlayer();
  Rx<Duration> _position = Duration.zero.obs;
  Rx<Duration> _duration = Duration.zero.obs;
  Rx<int> currentlyPlayingIndex = (-1).obs;
  Duration get position => _position.value;
  Duration get duration => _duration.value;

  @override
  void onInit() {
    audioPlayer.onPositionChanged.listen((position) {
      _position.value = position;
    });

    audioPlayer.onDurationChanged.listen((duration) {
      _duration.value = duration;
    });

    audioPlayer.onPlayerComplete.listen((_) {});

    super.onInit();
  }

  void seekTo(Duration newPosition) async {
    await audioPlayer.seek(newPosition);
  }

  AudioPlayer player = AudioPlayer();

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }

  void play(int index, String audioUrl) async {
    print('PlayIDs $currentlyPlayingIndex Or $index');
    print('objectPlay ${isPlaying.value}');

    if (currentlyPlayingIndex == index) {
      print('Pausing audio');
      if (isPlaying.value) {
        await audioPlayer.pause();
        isPlaying.value = false;
      } else {
        await audioPlayer.play(UrlSource(audioUrl));
        isPlaying.value = true;
      }
    } else {
      // Stop any currently playing audio
      if (currentlyPlayingIndex != -1) {
        print('Stopping previously playing audio');
        await audioPlayer.stop();
      }

      // Play the new audio
      print('Playing new audio');
      await audioPlayer.play(UrlSource(audioUrl));
      isPlaying.value = true;
      currentlyPlayingIndex.value = index;
    }
  }

  void playAudio(String url) async {
    try {
      isPlaying.value = true;
      await audioPlayer.play(UrlSource(url));
    } catch (e) {
      print("Error playing audio: $e");
    }
  }
//  final RxInt currentAudioIndex = 0.obs;

//   // Method to play the next audio URL
//   void playNextAudio() {
//     if (currentAudioIndex.value < controller.audioUrlsList.length - 1) {
//       // If there is a next audio URL in the list, play it
//       currentAudioIndex.value++;
//       controller.playAudio(controller.audioUrlsList[currentAudioIndex.value]);
//     } else {
//       // If we're at the end of the list, loop back to the beginning
//       currentAudioIndex.value = 0;
//       controller.playAudio(controller.audioUrlsList[0]);
//     }
//   }
  Future<void> pauseAudio() async {
    isPlaying.value = false;
    await audioPlayer.pause();
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
    // currentAudio.value = '';
  }

  RxBool isPlaying = true.obs;

  getAudioData() async {
    String currentToken = appStorage.read('userToken');
    // 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzgxYjA5Nzg5NzY1NWI3NTZkOTVjNDE0YzQ0MmNjNDc2YWUwOTVlMDNkZTY5Njk2OWFiOTFlMjFhYWRiYzEwZmFjMmVhODBlNjdjOTRmNDYiLCJpYXQiOjE3MDQyMzQ4ODEuOTUwMjM4OTQzMDk5OTc1NTg1OTM3NSwibmJmIjoxNzA0MjM0ODgxLjk1MDI0MTA4ODg2NzE4NzUsImV4cCI6MTczNTg1NzI4MS45NDY4NTQxMTQ1MzI0NzA3MDMxMjUsInN1YiI6IjIxIiwic2NvcGVzIjpbXX0.W_hs_C9UkIUBKNw1KYPzxF2ngvtp4WmVyrz7hQZbfOJyy_29SSHDpt87v0s4wfAr5vFhw5T9g3hq1hf7PV06bSj9zAUt-jnDyTtbsovo--dU_C6kTFPz9lxvcN-RM9u7Pm0cLRHz-O-_Dy53MllLQCiJ7TV3MwlayRwTe7xpmUYrO3iZVR-kBnFKpTCwN0BoswTOlQbft6NKJs60K-YaubtSMCCc4dBxddXn8GtNt1-aIC5k2Zcy2mrSvVvaPckQK1zdSr-ruALjPDnfQIwoyoK4zD7KbDI0iw7LsKEAVT3BlUwkxD1EeGg1eiRLOf1B72GddJOqbZbWShl-MCv1Hw6QAwQKhDw1inK73s8Mr9G_VUJvcaTjDMh07ZMnRJPrkKSFj-DBhlD6S3rJvp5SDqHpTrIFdlROrDbigOwfswAlrExAA19hc24vJN49OatrVTYhdVJo0deHE0hM7xe3AvUtmcyH5S5xMGJ_tDfORDhYcQLjurixrDunHzyscpo8vlatJZ15A6SN43c1ol5PqwWfoHcYOJifp_vCANRcZv4AXjh7kYd-rD3CvJo2om1AZTOG1jMduIxx_6AcMpltRRVEX4tug2ow-l1pt6R2vTrjK_QYMC4ufB9w5GRC8Zld-gkArWxAD46J1-mHSXa3DZIo0aQgVBJ61CBP9eJp0NY';
    print('inside $currentToken');
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(AppUrl.getAudio),
        headers: {
          'Authorization': "Bearer  $currentToken ",
          'Accept': "application/json"
        },
      );
      print('Audio Player Api Status');
      print(response.statusCode);
      print('Response Body');
      print(response.body);
      log(response.body);
      if (response.statusCode == 200) {
        // final Map<String, dynamic> responseData = json.decode(response.body);
        // AudioModel data = AudioModel.fromJson(responseData['data']);

        // print('  ${responseData['data']}');
        // final List<dynamic> responseData = json.decode(response.body);

        // // Assuming responseData is a list of items, iterate through them
        // for (var item in responseData) {
        //   AudioModel data = AudioModel.fromJson(item['data']);
        //   audioSoundList.add(data);
        // }
        // Parsing JSON
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          audioSoundList.clear();
          List<dynamic> data = responseData['data'];

          // Iterate through each item in the response and create an AudioModel instance
          for (var item in data) {
            AudioModel audioModel = AudioModel.fromJson(item);
            audioSoundList.add(audioModel);
            print('store');
          }

          isLoading.value = false;
          // Now, audioSoundList contains your data in the form of AudioModel instances
          // setState(() {});
        }
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      print('discover error');
    }
  }

  getMylibraryData() async {
    String currentToken = appStorage.read('userToken');
    // 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzgxYjA5Nzg5NzY1NWI3NTZkOTVjNDE0YzQ0MmNjNDc2YWUwOTVlMDNkZTY5Njk2OWFiOTFlMjFhYWRiYzEwZmFjMmVhODBlNjdjOTRmNDYiLCJpYXQiOjE3MDQyMzQ4ODEuOTUwMjM4OTQzMDk5OTc1NTg1OTM3NSwibmJmIjoxNzA0MjM0ODgxLjk1MDI0MTA4ODg2NzE4NzUsImV4cCI6MTczNTg1NzI4MS45NDY4NTQxMTQ1MzI0NzA3MDMxMjUsInN1YiI6IjIxIiwic2NvcGVzIjpbXX0.W_hs_C9UkIUBKNw1KYPzxF2ngvtp4WmVyrz7hQZbfOJyy_29SSHDpt87v0s4wfAr5vFhw5T9g3hq1hf7PV06bSj9zAUt-jnDyTtbsovo--dU_C6kTFPz9lxvcN-RM9u7Pm0cLRHz-O-_Dy53MllLQCiJ7TV3MwlayRwTe7xpmUYrO3iZVR-kBnFKpTCwN0BoswTOlQbft6NKJs60K-YaubtSMCCc4dBxddXn8GtNt1-aIC5k2Zcy2mrSvVvaPckQK1zdSr-ruALjPDnfQIwoyoK4zD7KbDI0iw7LsKEAVT3BlUwkxD1EeGg1eiRLOf1B72GddJOqbZbWShl-MCv1Hw6QAwQKhDw1inK73s8Mr9G_VUJvcaTjDMh07ZMnRJPrkKSFj-DBhlD6S3rJvp5SDqHpTrIFdlROrDbigOwfswAlrExAA19hc24vJN49OatrVTYhdVJo0deHE0hM7xe3AvUtmcyH5S5xMGJ_tDfORDhYcQLjurixrDunHzyscpo8vlatJZ15A6SN43c1ol5PqwWfoHcYOJifp_vCANRcZv4AXjh7kYd-rD3CvJo2om1AZTOG1jMduIxx_6AcMpltRRVEX4tug2ow-l1pt6R2vTrjK_QYMC4ufB9w5GRC8Zld-gkArWxAD46J1-mHSXa3DZIo0aQgVBJ61CBP9eJp0NY';
    print('inside $currentToken');
    audioisLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(AppUrl.getMyLibrary),
        headers: {
          'Authorization': "Bearer  $currentToken ",
          'Accept': "application/json"
        },
      );
      print('Get My Library Api Status');
      print(response.statusCode);
      print('Response Body');
      print(response.body);
      log(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          print('MyLibrary');
          print('MyLibrary');
          print(responseData['data']);
          getMyLibraryList.clear();
          List<dynamic> data = responseData['data'];

          // Iterate through each item in the response and create an AudioModel instance
          for (var item in data) {
            Map<String, dynamic> audioData = item['audio'];
            //  Map<String, dynamic> audioData = item['audio'];
            String audioUrl = audioData['file_path'];
            audioUrlsList.add(audioUrl);

            AudioModel audioModel = AudioModel.fromJson(audioData);
            getMyLibraryList.add(audioModel);
            print('store  ');
          }
          audioisLoading.value = false;
          // Now, audioSoundList contains your data in the form of AudioModel instances
        }
      }
    } catch (e) {
      audioisLoading.value = false;
      print(e.toString());
      print('My Library error');
    }
  }

  postMyLibrary(int audioId) async {
    String currentToken = appStorage.read('userToken');
    showDialogue();
    try {
      final response = await http.post(
        Uri.parse(AppUrl.postMyLibrary),
        headers: {
          'Authorization': "Bearer  $currentToken ",
          'Accept': "application/json"
        },
        body: {
          "audio_id": audioId.toString(),
        },
      );

      print('Status Code ${response.statusCode}');
      print('My Library Respones ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          getMylibraryData();
          showInSnackBar(responseData["message"], color: Colors.green);
          print(responseData["message"]);
          Get.back();
        } else {
          print(responseData['message']);
          print("Sign In failed: ${responseData['message']}");
        }
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);

        showInSnackBar(responseData["message"], color: Colors.red);
        Get.back();
        print("Response: ${responseData["message"]}");
      }
    } catch (error) {
      Get.back();
      print("Error: $error");
    }
  }

  deleteMyLibrary(int audioId) async {
    String currentToken = appStorage.read('userToken');
    showDialogue();
    try {
      final response = await http.post(
        Uri.parse(AppUrl.deleteMyLibrary),
        headers: {
          'Authorization': "Bearer  $currentToken ",
          'Accept': "application/json"
        },
        body: {
          "audio_id": audioId.toString(),
        },
      );

      print('Status Code ${response.statusCode}');
      print('Delete Library Respones ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          getMylibraryData();
          showInSnackBar(responseData["message"], color: Colors.green);
          print(responseData["message"]);
          Get.back();
        } else {
          print(responseData['message']);
          print("Sign In failed: ${responseData['message']}");
        }
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);

        showInSnackBar(responseData["message"], color: Colors.red);
        Get.back();
        print("Response: ${responseData["message"]}");
      }
    } catch (error) {
      Get.back();
      print("Delete Library Error: $error");
    }
  }

  // late AudioPlayer audioPlayer;
  // RxBool isAudioLoading = true.obs;

  // // Add an observable to track the current playing index
  // RxInt currentPlayingIndex = (-1).obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   audioPlayer = AudioPlayer();
  // }

  // Future<void> playAudio(String audioUrl, int index) async {
  //   // Stop the current playing audio if any
  //   if (audioPlayer.playing) {
  //     audioPlayer.stop();
  //   }

  //   await audioPlayer.setUrl(audioUrl);
  //   await audioPlayer.play();

  //   // Update the current playing index
  //   currentPlayingIndex.value = index;
  // }

  // Future<void> pauseAudio() async {
  //   if (audioPlayer.playing) {
  //     await audioPlayer.pause();
  //   }
  // }

  // Future<void> stopAudio() async {
  //   if (audioPlayer.playing) {
  //     await audioPlayer.stop();
  //   }
  // }

  // // Add any other necessary functions related to audio here

  // @override
  // void onClose() {
  //   audioPlayer.dispose();
  //   super.onClose();
  // }
}
