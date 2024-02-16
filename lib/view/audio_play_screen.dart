import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/Local%20Storage/global_variable.dart';
import 'package:squeak/components/custom.dart';
import 'package:squeak/controller/record_controller.dart';
import 'package:squeak/models/record_model.dart';
import 'package:squeak/view/menu.dart';
import 'package:squeak/view/purchase.dart';
import '../App_URL/apiurl.dart';
import '../components/app_assets.dart';
import '../components/colors.dart';
import '../components/custom_playbutton.dart';
import '../controller/audio_controller.dart';
import '../models/audio_model.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:squeak/components/colors.dart';
import 'package:squeak/models/audio_model.dart';

class AudioPlayScreen extends StatefulWidget {
  const AudioPlayScreen({super.key});

  @override
  State<AudioPlayScreen> createState() => _AudioPlayScreenState();
}

class _AudioPlayScreenState extends State<AudioPlayScreen> {
  recordController controllerRecord=Get.put(recordController());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? validateRecordingName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Your Recording Names';
    }

    return null;
  }

  void showDeleteBox(BuildContext context, {required record, required title,required id}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${title} "),
          content: Text("Do you want to delete this Recording ?"),
          actions: [
            TextButton(
              onPressed: () {
                controllerRecord.recordings.remove(record);
                controllerRecord.deleterecordings(id);

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

  saveRecording(BuildContext context, {required audiopath, required timer}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController recordingNames = TextEditingController();
        return AlertDialog(
          title: Form(
            key: _formKey,
            child: CustomTextField(
              hinttext: "Recording Title",
              controller: recordingNames,
              validator: validateRecordingName,
              showSuffixIcon: false,
              
            ),
          ),
        
          content: Text(
            "Do you want to save this Recording ?",
            style: TextStyle(color: AppColors.primaryColor,fontSize: 15),
          ),
          actions: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                onPressed: () {
                  
                  setState(() {
                    recordTimer = '00:00';
                  });
                  Get.back();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: AppColors.primaryColor,fontSize:20),
                )),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Get.back();
                      controllerRecord.postrecoding(RecordModel(
                        file: pathToAudio,
                        title: recordingNames.text,
                        audioLength: recordTimer
                
                
                      ));
                     
                      setState(() {
                        controllerRecord.recordings.insert(0,RecordModel(
                            
                            file: pathToAudio,
                            title: recordingNames.text,
                            audioLength: recordTimer,
                           
                           ));
                            recordTimer = '00:00';
                      });
                    }
                   
                    
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: AppColors.primaryColor,fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  late FlutterSoundRecorder _recordingSession;
  late FlutterSoundPlayer _recordingPlayer;
 
  String recordTimer = '00:00';
  late String pathToAudio;
  // List to hold recorded audio paths
  bool isRecording = false;
  bool isPlaying = false;
  int? currentIndexPlaying;
  bool isButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    controller.getAudioData();
    controller.getMylibraryData();
    controllerRecord.GetRecords();
  
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

  startRecording() async {
    if (isRecording) return;
    setState(() {
      isRecording = true;
      setState(() {
      isButtonEnabled = false;
    });
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
      isButtonEnabled=true;
    });
 print(pathToAudio);
    await _recordingSession.stopRecorder();
    saveRecording(context, audiopath: pathToAudio, timer: recordTimer);
   
    // setState(() {
    //   recordings.add(AudioModel(
    //       id: 1,
    //       filePath: pathToAudio,
    //       title: "audio1",
    //       time: recordTimer,
    //       type: "public",    
    //       price: "20",
    //       count: 1));
    // });
  }

  playAudio(String path) async {
    print(path);
    if (isPlaying) return;
    setState(() {
      isPlaying = true;
    });
    try {
      await _recordingPlayer.openPlayer(); 
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

  AudioController controller = Get.put(AudioController());

  late List<bool> isPlayingList;
  final RxInt currentAudioIndex = 0.obs;
  bool isCurrent = false;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   controller.getAudioData();
  //   controller.getMylibraryData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('My Screen'),
        // ),
        body: Container(
            height: Get.height * 1,
            width: Get.width * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.backgroundmain),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(children: [
              Customhead(),
              SizedBox(height: Get.height * 0.02),
              Obx(() => CustonPlayButton(
                    playIcon: Icon(
                        controller.isPlaying.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 42,
                        color: AppColors.buttoncolor),
                    playTap: () async {
                      print('object123');
                      print(controller.isPlaying.value);
                      if (controller.isPlaying.value) {
                        controller.pauseAudio();
                      } else {
                        controller.playAudio(
                            '${AppUrl.audioPath + controller.audioUrlsList[0]}');
                      }
                    },
                    previousTap: () {},
                    nextTap: () {
                      // if (currentAudioIndex.value <
                      //     controller.audioUrlsList.length - 1) {
                      //   print('objectNext');
                      //   // If there is a next audio URL in the list, play it
                      //   currentAudioIndex.value++;
                      //   controller.playAudio(
                      //       '${AppUrl.audioPath + controller.audioUrlsList[currentAudioIndex.value]}');
                      // } else {
                      //   print('objectNextNot');
                      //   // If we're at the end of the list, loop back to the beginning
                      //   currentAudioIndex.value = 0;
                      //   controller.playAudio(
                      //       '${AppUrl.audioPath + controller.audioUrlsList[0]}');
                      // }
                    },
                  )),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isCurrent = false;
                              });
                            },
                            child: Container(
                              width: Get.width * 0.45,
                              padding: EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  color: isCurrent
                                      ? Colors.black
                                      : Color.fromARGB(255, 20, 20, 20),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  'Sound Library',
                                  style: TextStyle(
                                      color: isCurrent
                                          ? AppColors.whitecolor
                                          : AppColors.primaryColor,
                                      fontSize: isCurrent ? 18 : 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isCurrent = true;
                              });
                            },
                            child: Container(
                              width: Get.width * 0.45,
                              padding: EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  color: isCurrent
                                      ? Color.fromARGB(255, 20, 20, 20)
                                      : Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  'My Recorder',
                                  style: TextStyle(
                                      color: isCurrent
                                          ? AppColors.primaryColor
                                          : AppColors.whitecolor,
                                      fontSize: isCurrent ? 20 : 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      isCurrent
                          ? Expanded(
                              child: Obx(() => Column(
                                    children: [
                                      Text(
                                        recordTimer,
                                        style: TextStyle(
                                            fontSize: 32,
                                            color: AppColors.primaryColor),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () =>   isButtonEnabled? startRecording():null,
                                            child: Container(
                                              height: Get.height * 0.037,
                                              width: Get.width * 0.22,
                                              decoration: BoxDecoration(
                                                  color: isButtonEnabled?AppColors.primaryColor:Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  "Record",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color:
                                                          AppColors.whitecolor,
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  "Stop",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color:
                                                          AppColors.whitecolor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    
                                      Obx(() => controllerRecord.isLoading.value? Padding(
                                        padding: const EdgeInsets.only(top: 50),
                                        child: CircularProgressIndicator(color: AppColors.primaryColor,),
                                      ):controllerRecord.recordings.isEmpty
                            ? Padding(
                              padding: const EdgeInsets.only(top: 70),
                              child: Center(
                                  child: Text(
                                    'You have No recordings',
                                    style:
                                        TextStyle(color: AppColors.primaryColor,fontSize: 20),
                                  ),
                                ),
                            )
                            : Expanded(
                                        child: ListView.builder(
                                              itemCount:  controllerRecord.recordings.length,
                                              itemBuilder: (context, index) {
                                                RecordModel recordingPath =
                                                    controllerRecord.recordings[index];
                                                bool isCurrentlyPlaying =
                                                    index ==
                                                        currentIndexPlaying;
                                                print(recordingPath.file);
                                                return Container(
                                                  height: Get.height * 0.065,
                                                  decoration: BoxDecoration(),
                                                  child: 
                                                     Container(
                                                      margin: EdgeInsets.symmetric(horizontal: 15),
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            color: AppColors.whitecolor
                                                          )
                                                        )
                                                      ),
                                                       child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                                    onTap: () {
                                                                      // _playAudio(recordingPath);
                                                                      if (currentIndexPlaying ==
                                                                          index) {
                                                                        stopPlayback();
                                                                        currentIndexPlaying =
                                                                            null;
                                                                      } else {
                                                                        playAudio(
                                                                            recordingPath
                                                                                .file!.toString());
                                                                        currentIndexPlaying =
                                                                            index;
                                                                      }
                                                                    },
                                                                    child: Icon(
                                                                      isCurrentlyPlaying
                                                                          ? Icons
                                                                              .pause
                                                                          : Icons
                                                                              .play_arrow,
                                                                      color: AppColors
                                                                          .whitecolor,
                                                                    )),
                                                                     Text(
                                                          recordingPath.title!,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              fontSize: 20)),
                                                              Text(
                                                        "Audio length: ${recordingPath.audioLength}",
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .whitecolor),
                                                                                                           ),
                                                                                                           GestureDetector(
                                                                onTap: () {
                                                                  showDeleteBox(
                                                                      context,
                                                                      record:
                                                                          controllerRecord.recordings[
                                                                              index],
                                                                              id: recordingPath.id.toString(),
                                                                      title: recordingPath
                                                                          .title);
                                                                          
                                                                                               
                                                                  // print("Removing");
                                                                  // _recordings.removeAt(index);
                                                                },
                                                                child: Icon(
                                                                  Icons.delete,
                                                                  color: AppColors
                                                                      .whitecolor,
                                                                )),
                                                        ],
                                                                                                           ),
                                                     ),
                                                   
                                                    
                                                );
                                              },
                                            ),
                                      ))
                                    ],
                                  )),
                            )
                          : Expanded(
                              child: Obx(
                                () => SizedBox(
                                  // width: Get.width * 0.8,
                                  child: controller.isLoading.value
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                          ),
                                        )
                                      : controller.audioSoundList.isEmpty
                                          ? const Center(
                                              child: Text('List is Empty..'),
                                            )
                                          : ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              itemCount: controller
                                                  .audioSoundList.length,
                                              itemBuilder: (Context, index) {
                                                AudioModel item = controller
                                                    .audioSoundList[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 13, right: 13),
                                                  child: Container(
                                                      height:
                                                          Get.height * 0.047,
                                                      width: Get.width * 0.8,
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  color: AppColors
                                                                      .whitecolor,
                                                                  width: 2))),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Obx(() =>
                                                              GestureDetector(
                                                                child: Icon(
                                                                  controller.currentlyPlayingIndex
                                                                                  .value ==
                                                                              index &&
                                                                          controller
                                                                              .isPlaying
                                                                              .value
                                                                      ? Icons
                                                                          .pause
                                                                      : Icons
                                                                          .play_arrow,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onTap:
                                                                    () async {
                                                                  controller.play(
                                                                      index,
                                                                      '${AppUrl.audioPath + item.filePath}');
                                                                },
                                                              )),
                                                          Text(
                                                            item.title,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .whitecolor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),)
                                                          // ),
                                                          // Text(
                                                          //   item.time,
                                                          //   style: TextStyle(
                                                          //       color: AppColors
                                                          //           .whitecolor,
                                                          //       fontWeight:
                                                          //           FontWeight
                                                          //               .w800),
                                                          // ),
                                                          // Text(
                                                          //   "${item.count} treats",
                                                          //   style: TextStyle(
                                                          //       color: AppColors
                                                          //           .primaryColor,
                                                          //       fontWeight:
                                                          //           FontWeight
                                                          //               .w800),
                                                          // ),
                                                          // item.type == 'free'
                                                          //     ? GestureDetector(
                                                          //         onTap: () {
                                                          //           controller
                                                          //               .postMyLibrary(
                                                          //                   item.id);
                                                          //         },
                                                          //         child: Icon(
                                                          //           Icons
                                                          //               .cloud_download_outlined,
                                                          //           color: AppColors
                                                          //               .whitecolor,
                                                          //           size: 30,
                                                          //         ),
                                                          //       )
                                                          //     : Container(
                                                          //         padding: const EdgeInsets
                                                          //             .symmetric(
                                                          //             horizontal:
                                                          //                 10,
                                                          //             vertical:
                                                          //                 5),
                                                          //         decoration: BoxDecoration(
                                                          //             borderRadius:
                                                          //                 BorderRadius.circular(
                                                          //                     15),
                                                          //             color: Colors
                                                          //                 .red),
                                                          //         child:
                                                          //             const Text(
                                                          //           'buy',
                                                          //           style: TextStyle(
                                                          //               color: Colors
                                                          //                   .white,
                                                          //               fontWeight:
                                                          //                   FontWeight.normal),
                                                          //         ),
                                                          //       )
                                                        ],
                                                      )),
                                                );
                                              }),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              )
            ])));
  }
}
