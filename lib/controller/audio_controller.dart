import 'dart:convert';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:squeak/components/colors.dart';
import '../App_URL/apiurl.dart';
import '../Local Storage/global_variable.dart';
import '../components/custom_snakbar.dart';
import '../global/alertbox.dart';
import '../models/audio_model.dart';

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
    audioPlayer.dispose();
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
    print(url);
    try {
      isPlaying.value = true;
      await audioPlayer.play(UrlSource(url));
    } catch (e) {
      print("Error playing audio: $e");
    }
  }
//  final RxInt currentAudioIndex = 0.obs;

  Future<void> pauseAudio() async {
    isPlaying.value = false;
    await audioPlayer.pause();
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
    // currentAudio.value = '';
  }

  RxBool isPlaying = false.obs;

  getAudioData() async {
    String currentToken = appStorage.read('userToken');
   
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
            print( "${AppUrl.audioPath + item["file_path"]}");
           
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
          showInSnackBar(responseData["message"], color:AppColors.greencolor);
          print(responseData["message"]);
          Get.back();
        } else {
          print(responseData['message']);
          print("Sign In failed: ${responseData['message']}");
        }
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);

        showInSnackBar(responseData["message"], color:AppColors.errorcolor);
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
          showInSnackBar(responseData["message"], color:AppColors.greencolor);
          print(responseData["message"]);
          Get.back();
        } else {
          print(responseData['message']);
          print("Sign In failed: ${responseData['message']}");
        }
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);

        showInSnackBar(responseData["message"], color: AppColors.errorcolor);
        Get.back();
        print("Response: ${responseData["message"]}");
      }
    } catch (error) {
      Get.back();
      print("Delete Library Error: $error");
    }
  }
}
