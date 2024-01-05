import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:squeak/App_URL/apiurl.dart';
import 'package:squeak/controller/audio_controller.dart';
import 'package:squeak/dumy%20Models/audio_model.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';

import '../components/colors.dart';

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen>
    with SingleTickerProviderStateMixin {
  AudioController controller = Get.put(AudioController());
  late TabController _tabController;
  late AudioPlayer _audioPlayer;
  int _currentPlayingIndex = -1;
  // String _audioUrl =
  //     'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';

  @override
  void initState() {
    super.initState();
    controller.getAudioData();
    _audioPlayer = AudioPlayer();
    // _initAudioPlayer();
    _tabController = TabController(length: 2, vsync: this);
  }

  // _initAudioPlayer() async {
  //   await _audioPlayer.setUrl(_audioUrl);
  // }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Center(
                  child: Container(
                    height: Get.height * 0.087555,
                    child: const Center(
                      child: Tab(text: 'Sound Library'),
                    ),
                  ),
                ),
                Center(
                    child: Container(
                        height: Get.height * 0.09,
                        width: Get.width * 0.7,
                        child: const Tab(text: 'My Library'))),
              ],
              labelColor: AppColors.primaryColor,
              labelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.25),
              unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.85),
              unselectedLabelColor: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: TabBarView(
          controller: _tabController,
          children: [
            Obx(
              () => SizedBox(
                width: Get.width * 0.8,
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
                            itemCount: controller.audioSoundList.length,
                            itemBuilder: (Context, index) {
                              AudioModel item =
                                  controller.audioSoundList[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 13, right: 13),
                                child: Container(
                                    height: Get.height * 0.047,
                                    width: Get.width * 0.8,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppColors.whitecolor,
                                                width: 2))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          child: Icon(
                                            _audioPlayer.playing &&
                                                    _currentPlayingIndex ==
                                                        index
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            color: Colors.white,
                                          ),
                                          onTap: () async {
                                            await _audioPlayer.setUrl(
                                                '${AppUrl.audioPath + item.filePath}');

                                            if (_audioPlayer.playing &&
                                                _currentPlayingIndex == index) {
                                              _audioPlayer.pause();
                                            } else {
                                              _audioPlayer.play();
                                            }

                                            setState(() {
                                              _currentPlayingIndex = index;
                                            });
                                          },
                                        ),
                                        // GestureDetector(
                                        //   child: Icon(
                                        //     _audioPlayer.playing
                                        //         ? Icons.pause
                                        //         : Icons.play_arrow,
                                        //     color: Colors.white,
                                        //   ),
                                        //   onTap: () async {
                                        //     await _audioPlayer.setUrl(_audioUrl);
                                        //     if (_audioPlayer.playing) {
                                        //       _audioPlayer.pause();
                                        //     } else {
                                        //       _audioPlayer.play();
                                        //     }
                                        //     setState(() {}); // Trigger a rebuild
                                        //   },
                                        // ),

                                        Text(
                                          item.title,
                                          style: TextStyle(
                                              color: AppColors.whitecolor,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Text(
                                          item.time,
                                          style: TextStyle(
                                              color: AppColors.whitecolor,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Text(
                                          "${item.count} treats",
                                          style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        item.type == 'free'
                                            ? GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .postMyLibrary(item.id);
                                                },
                                                child: Icon(
                                                  Icons.cloud_download_outlined,
                                                  color: AppColors.whitecolor,
                                                  size: 30,
                                                ),
                                              )
                                            : Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Colors.red),
                                                child: const Text(
                                                  'buy',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              )
                                      ],
                                    )),
                              );
                            }),
              ),
            ),
            Container(
              height: Get.height * 0.25,
              width: Get.width * 0.8,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: controller.audioSoundList.length,
                  itemBuilder: (Context, index) {
                    AudioModel item = controller.audioSoundList[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: Container(
                          height: Get.height * 0.047,
                          width: Get.width * 0.8,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.whitecolor, width: 2))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // audio.play,
                              Text(
                                item.title,
                                style: TextStyle(
                                    color: AppColors.whitecolor,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Text(
                                item.time,
                                style: TextStyle(
                                    color: AppColors.whitecolor,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                width: Get.width * 0.1,
                              ),
                              // item.bin,
                            ],
                          )),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
