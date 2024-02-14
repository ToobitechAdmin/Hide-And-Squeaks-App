import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:squeak/components/colors.dart';
import 'package:squeak/models/audio_model.dart';

class AudioRecord extends StatefulWidget {
  @override
  _AudioRecordState createState() => _AudioRecordState();
}

class _AudioRecordState extends State<AudioRecord> {
  void showDeleteBox(BuildContext context, {required record, required title}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${title} "),
          content: Text("Do you want to delete this Recording ?"),
          actions: [
            TextButton(
              onPressed: () {
                recordings.remove(record);

                Get.back();
              },
              child: Text(
                "OK",
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  late FlutterSoundRecorder _recordingSession;
  late FlutterSoundPlayer _recordingPlayer;
  RxList<AudioModel> recordings = <AudioModel>[].obs;
  String recordTimer = '00:00';
  late String pathToAudio;
  // List to hold recorded audio paths
  bool isRecording = false;
  bool isPlaying = false;
  int? currentIndexPlaying;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    _recordingSession = FlutterSoundRecorder();
    _recordingPlayer = FlutterSoundPlayer();
    await _recordingSession.openRecorder();
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    setState(() {
      recordTimer = '00:00';
    });
  }

  @override
  void dispose() {
    _recordingSession.closeRecorder();
    _recordingPlayer.closePlayer();
    super.dispose();
  }

  Future<void> startRecording() async {
    if (isRecording) return;
    setState(() {
      isRecording = true;
    });
    pathToAudio = (await getTemporaryDirectory()).path +
        '/recording_${DateTime.now().millisecondsSinceEpoch}.wav';
    await _recordingSession.startRecorder(
      toFile: pathToAudio,
      codec: Codec.pcm16WAV,
    );
    startTimer();
  }

  stopRecording() async {
    if (!isRecording) return;
    setState(() {
      isRecording = false;
    });
    await _recordingSession.stopRecorder();
    setState(() {
      recordings.add(AudioModel(
          id: 1,
          filePath: pathToAudio,
          title: "audio1",
          time: recordTimer,
          type: "public",
          price: "20",
          count: 1));
    });
    setState(() {
      recordTimer = '00:00';
    });
  }

  playAudio(String path) async {
    if (isPlaying) return;
    setState(() {
      isPlaying = true;
    });
    try {
      await _recordingPlayer.openPlayer(); // Open the player
      await _recordingPlayer.startPlayer(fromURI: path);
      _recordingPlayer.onProgress!.listen((e) {
        if (e != null) {
          final currentPosition = e.position.inSeconds;
          final duration = e.duration.inSeconds;
          setState(() {
            recordTimer = DateFormat('mm:ss', 'en_US')
                .format(DateTime(0, 0, 0, 0, 0, currentPosition));
          });
          if (currentPosition >= duration) {
            _recordingPlayer.stopPlayer();
            setState(() {
              isPlaying = false;
              recordTimer = '00:00';
            });
          }
        }
      });
    } catch (e) {
      print('Error playing recording: $e');
      setState(() {
        isPlaying = false;
      });
    }
  }

  stopPlayback() async {
    if (!isPlaying) return;
    setState(() {
      isPlaying = false;
    });
    await _recordingPlayer.stopPlayer();
  }

  startTimer() {
    DateTime startTime = DateTime.now();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isRecording) {
        timer.cancel();
      } else {
        final currentTime = DateTime.now();
        final elapsed = currentTime.difference(startTime);
        setState(() {
          recordTimer = DateFormat('mm:ss', 'en_US').format(
              DateTime(0, 0, 0, 0, elapsed.inMinutes, elapsed.inSeconds));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audio Recording and Playing')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            recordTimer,
            style: TextStyle(fontSize: 32),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => startRecording(),
                child: Container(
                  height: Get.height * 0.037,
                  width: Get.width * 0.22,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Start Recording",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.whitecolor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () => stopRecording(),
                child: Container(
                  height: Get.height * 0.037,
                  width: Get.width * 0.22,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Stop Recording",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.whitecolor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
              child: Obx(
            () => ListView.builder(
              itemCount: recordings.length,
              itemBuilder: (context, index) {
                AudioModel recordingPath = recordings[index];
                bool isCurrentlyPlaying = index == currentIndexPlaying;
                return ListTile(
                  title: Text('Recording ${index + 1}'),
                  trailing: Container(
                    width: Get.width * 0.15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              // _playAudio(recordingPath);
                              if (currentIndexPlaying == index) {
                                stopPlayback();
                                currentIndexPlaying = null;
                              } else {
                                playAudio(recordingPath.filePath);
                                currentIndexPlaying = index;
                              }
                            },
                            child: Icon(isCurrentlyPlaying
                                ? Icons.pause
                                : Icons.play_arrow)),
                        GestureDetector(
                            onTap: () {
                              showDeleteBox(context,
                                  record: recordings[index],
                                  title: "Recording ${index + 1}");

                              // print("Removing");
                              // _recordings.removeAt(index);
                            },
                            child: Icon(Icons.delete)),
                      ],
                    ),
                  ),
                  subtitle: Text("Audio length: ${recordingPath.time}"),
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}
