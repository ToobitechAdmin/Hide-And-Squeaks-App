import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/view/menu.dart';
import '../App_URL/apiurl.dart';
import '../components/app_assets.dart';
import '../components/colors.dart';
import '../components/custom_playbutton.dart';
import '../components/snakbar.dart';
import '../controller/audio_controller.dart';
import '../models/audio_model.dart';

class AudioPlayScreen extends StatefulWidget {
  const AudioPlayScreen({super.key});

  @override
  State<AudioPlayScreen> createState() => _AudioPlayScreenState();
}

class _AudioPlayScreenState extends State<AudioPlayScreen> {
  AudioController controller = Get.put(AudioController());
  late List<bool> isPlayingList;
  final RxInt currentAudioIndex = 0.obs;
  // bool isCurrent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('My Screen'),
        // ),
        body: SafeArea(
            child: Container(
                height: Get.height * 1,
                width: Get.width * 1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.backgroundmain),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Get.to(PurchaseScreen());
                          },
                          child: Container(
                            height: Get.height * 0.069,
                            width: Get.width * 0.15,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppAssets.heart),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        Container(
                          height: Get.height * 0.085,
                          width: Get.width * 0.29,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(AppAssets.signin),
                                  fit: BoxFit.fill)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(MenuScreen());
                          },
                          child: Container(
                              height: Get.height * 0.08,
                              width: Get.width * 0.12,
                              child: Icon(
                                Icons.menu_rounded,
                                color: AppColors.primaryColor,
                                size: 50,
                              )),
                        )
                      ],
                    ),
                  ),
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
                        previousTap: () {
                          if (controller.audioUrlsList.isNotEmpty) {
                            if (currentAudioIndex.value > 0) {
                              // If there is a previous audio URL in the list, play it
                              print('Previous One');
                              currentAudioIndex.value--;
                              controller.playAudio(
                                '${AppUrl.audioPath + controller.audioUrlsList[currentAudioIndex.value]}',
                              );
                            } else {
                              print('Previous Two');
                              // If we're at the beginning of the list, loop to the end
                              currentAudioIndex.value =
                                  controller.audioUrlsList.length - 1;
                              controller.playAudio(
                                '${AppUrl.audioPath + controller.audioUrlsList[currentAudioIndex.value]}',
                              );
                            }
                          } else {
                            showInSnackBar('Audio not available',
                                color: Colors.red);
                          }
                        },
                        nextTap: () {
                          if (controller.audioUrlsList.isNotEmpty) {
                            if (currentAudioIndex.value <
                                controller.audioUrlsList.length - 1) {
                              print('Next One');
                              // If there is a next audio URL in the list, play it
                              currentAudioIndex.value++;
                              controller.playAudio(
                                '${AppUrl.audioPath + controller.audioUrlsList[currentAudioIndex.value]}',
                              );
                            } else {
                              print('Next Two');
                              // If we're at the end of the list, loop back to the beginning
                              currentAudioIndex.value = 0;
                              controller.playAudio(
                                '${AppUrl.audioPath + controller.audioUrlsList[0]}',
                              );
                            }
                          } else {
                            showInSnackBar('audio not available',
                                color: Colors.red);
                          }
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
                          Container(
                                  width: Get.width,
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 20, 20, 20),
                                      // isCurrent
                                      //     ? Color.fromARGB(255, 20, 20, 20)
                                      //     : Colors.black,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20))),
                                  child: Center(
                                    child: Text(
                                      'My Library',
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          // isCurrent
                                          //     ? AppColors.primaryColor
                                          //     : AppColors.whitecolor,
                                          fontSize:20,
                                          //  isCurrent ? 20 : 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     GestureDetector(
                          //       onTap: () {
                          //         setState(() {
                          //           isCurrent = false;
                          //         });
                          //       },
                          //       child: Container(
                          //         width: Get.width * 0.45,
                          //         padding: EdgeInsets.symmetric(vertical: 20),
                          //         decoration: BoxDecoration(
                          //             color: isCurrent
                          //                 ? Colors.black
                          //                 : Color.fromARGB(255, 20, 20, 20),
                          //             borderRadius: BorderRadius.only(
                          //                 topLeft: Radius.circular(20))),
                          //         child: Center(
                          //           child: Text(
                          //             'Sound Library',
                          //             style: TextStyle(
                          //                 color: isCurrent
                          //                     ? AppColors.whitecolor
                          //                     : AppColors.primaryColor,
                          //                 fontSize: isCurrent ? 18 : 20,
                          //                 fontWeight: FontWeight.w700),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     GestureDetector(
                          //       onTap: () {
                          //         setState(() {
                          //           isCurrent = true;
                          //         });
                          //       },
                          //       child: Container(
                          //         width: Get.width * 0.45,
                          //         padding: EdgeInsets.symmetric(vertical: 20),
                          //         decoration: BoxDecoration(
                          //             color: isCurrent
                          //                 ? Color.fromARGB(255, 20, 20, 20)
                          //                 : Colors.black,
                          //             borderRadius: BorderRadius.only(
                          //                 topRight: Radius.circular(20))),
                          //         child: Center(
                          //           child: Text(
                          //             'My Library',
                          //             style: TextStyle(
                          //                 color: isCurrent
                          //                     ? AppColors.primaryColor
                          //                     : AppColors.whitecolor,
                          //                 fontSize: isCurrent ? 20 : 18,
                          //                 fontWeight: FontWeight.w700),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          
                          // isCurrent
                          //     ? 
                              Expanded(
                                  child: Obx(
                                    () => SizedBox(
                                      // width: Get.width * 0.8,
                                      child: controller.audioisLoading.value
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.primaryColor,
                                              ),
                                            )
                                          : controller.getMyLibraryList.isEmpty
                                              ? const Center(
                                                  child: Text(
                                                    'List is Empty..',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              : ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: controller
                                                      .getMyLibraryList.length,
                                                  itemBuilder:
                                                      (Context, index) {
                                                    AudioModel item = controller
                                                            .getMyLibraryList[
                                                        index];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 13,
                                                              right: 13),
                                                      child: Container(
                                                          height: Get.height *
                                                              0.047,
                                                          width:
                                                              Get.width * 0.8,
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      color: AppColors
                                                                          .whitecolor,
                                                                      width:
                                                                          2))),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Obx(() =>
                                                                  GestureDetector(
                                                                    child: Icon(
                                                                      controller.currentlyPlayingIndex.value == index &&
                                                                              controller
                                                                                  .isPlaying.value
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
                                                                            .w800),
                                                              ),
                                                              Text(
                                                                item.time,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .whitecolor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Text(
                                                                "${item.count} treats",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  controller
                                                                      .deleteMyLibrary(
                                                                          item.id);
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .delete_outline,
                                                                  color: AppColors
                                                                      .whitecolor,
                                                                  size: 30,
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    );
                                                  }),
                                    ),
                                  ),
                                )
                              // : Expanded(
                              //     child: Obx(
                              //       () => SizedBox(
                              //         // width: Get.width * 0.8,
                              //         child: controller.isLoading.value
                              //             ? Center(
                              //                 child: CircularProgressIndicator(
                              //                   color: AppColors.primaryColor,
                              //                 ),
                              //               )
                              //             : controller.audioSoundList.isEmpty
                              //                 ? const Center(
                              //                     child: Text(
                              //                       'List is Empty..',
                              //                       style: TextStyle(
                              //                           color: Colors.white),
                              //                     ),
                              //                   )
                              //                 : ListView.builder(
                              //                     scrollDirection:
                              //                         Axis.vertical,
                              //                     itemCount: controller
                              //                         .audioSoundList.length,
                              //                     itemBuilder:
                              //                         (Context, index) {
                              //                       AudioModel item = controller
                              //                           .audioSoundList[index];
                              //                       return Padding(
                              //                         padding:
                              //                             const EdgeInsets.only(
                              //                                 left: 13,
                              //                                 right: 13),
                              //                         child: Container(
                              //                             height: Get.height *
                              //                                 0.047,
                              //                             width:
                              //                                 Get.width * 0.8,
                              //                             decoration: BoxDecoration(
                              //                                 border: Border(
                              //                                     bottom: BorderSide(
                              //                                         color: AppColors
                              //                                             .whitecolor,
                              //                                         width:
                              //                                             2))),
                              //                             child: Row(
                              //                               mainAxisAlignment:
                              //                                   MainAxisAlignment
                              //                                       .spaceEvenly,
                              //                               children: [
                              //                                 Obx(() =>
                              //                                     GestureDetector(
                              //                                       child: Icon(
                              //                                         controller.currentlyPlayingIndex.value == index &&
                              //                                                 controller
                              //                                                     .isPlaying.value
                              //                                             ? Icons
                              //                                                 .pause
                              //                                             : Icons
                              //                                                 .play_arrow,
                              //                                         color: Colors
                              //                                             .white,
                              //                                       ),
                              //                                       onTap:
                              //                                           () async {
                              //                                         controller.play(
                              //                                             index,
                              //                                             '${AppUrl.audioPath + item.filePath}');
                              //                                       },
                              //                                     )),
                              //                                 Text(
                              //                                   item.title,
                              //                                   style: TextStyle(
                              //                                       color: AppColors
                              //                                           .whitecolor,
                              //                                       fontWeight:
                              //                                           FontWeight
                              //                                               .w800),
                              //                                 ),
                              //                                 Text(
                              //                                   item.time,
                              //                                   style: TextStyle(
                              //                                       color: AppColors
                              //                                           .whitecolor,
                              //                                       fontWeight:
                              //                                           FontWeight
                              //                                               .w800),
                              //                                 ),
                              //                                 Text(
                              //                                   "${item.count} treats",
                              //                                   style: TextStyle(
                              //                                       color: AppColors
                              //                                           .primaryColor,
                              //                                       fontWeight:
                              //                                           FontWeight
                              //                                               .w800),
                              //                                 ),
                              //                                 item.type ==
                              //                                         'free'
                              //                                     ? GestureDetector(
                              //                                         onTap:
                              //                                             () {
                              //                                           controller
                              //                                               .postMyLibrary(item.id);
                              //                                         },
                              //                                         child:
                              //                                             Icon(
                              //                                           Icons
                              //                                               .cloud_download_outlined,
                              //                                           color: AppColors
                              //                                               .whitecolor,
                              //                                           size:
                              //                                               30,
                              //                                         ),
                              //                                       )
                              //                                     : Container(
                              //                                         padding: const EdgeInsets
                              //                                             .symmetric(
                              //                                             horizontal:
                              //                                                 10,
                              //                                             vertical:
                              //                                                 5),
                              //                                         decoration: BoxDecoration(
                              //                                             borderRadius: BorderRadius.circular(
                              //                                                 15),
                              //                                             color:
                              //                                                 Colors.red),
                              //                                         child:
                              //                                             const Text(
                              //                                           'buy',
                              //                                           style: TextStyle(
                              //                                               color:
                              //                                                   Colors.white,
                              //                                               fontWeight: FontWeight.normal),
                              //                                         ),
                              //                                       )
                              //                               ],
                              //                             )),
                              //                       );
                              //                     }),
                              //       ),
                              //     ),
                              //   )
                        ],
                      ),
                    ),
                  )
                ]))));
  }
}
