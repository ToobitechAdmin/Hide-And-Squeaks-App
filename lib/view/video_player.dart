import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/App_URL/apiurl.dart';
import 'package:squeak/Local%20Storage/global_variable.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/controller/video_controller.dart';
import 'package:squeak/models/comment_model.dart';
import 'package:squeak/models/video_model.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';

import '../components/colors.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoModel view;
  final List<Comment> comments;

  VideoPlayerScreen({required this.view, required this.comments});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  TextEditingController commentController = TextEditingController();
  VideoController controller = Get.put(VideoController());
  GlobalKey<FormState> _commentkey = GlobalKey<FormState>();
  addLike() {
    widget.view.totalLikes! + 1;
  }

  String? validateComment(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Comment';
    }
    return null;
  }

  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  bool isLiked = false;
  late VideoPlayerController _controller;

  bool _isPlaying = false;
  bool _displayControls = true;
  @override
  void initState() {
    super.initState();
    controller.ViewData(widget.view.id!.toString());

    _initializeController(widget.view.file_path.toString());
  }

  void _toggleControls() {
    setState(() => _displayControls = !_displayControls);
  }

  _initializeController(String videoUrl) async {
    VideoPlayerController newController =
        VideoPlayerController.network(videoUrl);

    await newController.initialize();
    newController.setLooping(true);

    newController.addListener(() {
      setState(() {
        _isPlaying = newController.value.isPlaying;
        if (_isPlaying) {
          Future.delayed(Duration(seconds: 5), () {
            if (newController.value.isPlaying) {
              setState(() => _displayControls = false);
            }
          });
        }
      });
    });

    if (mounted) {
      setState(() {
        _controller = newController;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String newdate = formatDate(widget.view.created_at.toString());
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: Get.height * 1,
            width: Get.width * 1,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.backgroundmain),
                    fit: BoxFit.fill)),
            child: SingleChildScrollView(
              child: Obx(
                () => controller.isLoading.value
                    ? CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )
                    : Column(
                        children: [
                          Container(
                            height: Get.height * 0.5,
                            width: Get.width * 1,
                            child: _controller.value.isInitialized
                                ? AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: _toggleControls,
                                          child: VideoPlayer(_controller),
                                        ),
                                        _displayControls
                                            ? _ControlsOverlay(
                                                controller: _controller)
                                            : Container(),
                                        VideoProgressIndicator(
                                          _controller,
                                          allowScrubbing: true,
                                          colors: VideoProgressColors(
                                            playedColor: AppColors.primaryColor,
                                            bufferedColor: Colors.grey,
                                            backgroundColor: Colors.black38,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                        height: Get.height * 0.05,
                                        width: Get.width * 0.1,
                                        child: CircularProgressIndicator(
                                            color: AppColors.primaryColor)),
                                  ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: Get.height * 0.037,
                                      width: Get.width * 0.22,
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text(
                                          "Share",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: AppColors.whitecolor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Form(
                                      key: _commentkey,
                                      child: TextFormField(
                                        validator: validateComment,
                                        controller: commentController,
                                        textAlign: TextAlign.start,
                                        cursorColor: AppColors.whitecolor,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                        decoration: InputDecoration(
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              if (_commentkey.currentState
                                                      ?.validate() ??
                                                  false) {
                                                print(widget.view.id!);
                                                controller.postComment(
                                                    commentController.text,
                                                    widget.view.id!);
                                                controller.ViewData(
                                                    widget.view.id!.toString());

                                                Comment newComment = Comment(
                                                    comment:
                                                        commentController.text,
                                                    userId: widget.view.id,
                                                    user: User(
                                                        id: widget.view.id!,
                                                        name: appStorage
                                                            .read("name")
                                                            .toString(),
                                                        profile: appStorage
                                                            .read("profile")
                                                            .toString()));

                                                setState(() {
                                                  widget.comments
                                                      .add(newComment);
                                                });
                                                commentController.clear();
                                              }
                                            },
                                            child: Icon(
                                              Icons.post_add,
                                              color: AppColors.whitecolor,
                                              size: 25,
                                            ),
                                          ),
                                          hintText: "Comment",
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 2.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 2.0),
                                          ),
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          constraints: BoxConstraints.tightFor(
                                            height: Get.height * 0.04,
                                            width: Get.width * 0.56,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        addLike();
                                        setState(() {
                                          isLiked = !isLiked;
                                        });

                                        controller.postLike(widget.view.id!);


                                       
                                      },
                                      child: Icon(
                                        Icons.favorite_outlined,
                                        color: isLiked
                                            ? AppColors.favouritecolor
                                            : AppColors.whitecolor,
                                        size: 30,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.005,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppColors.whitecolor,
                                                width: 1))),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 2,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: Get.width * 0.57,
                                            height: Get.height * 0.05,
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  radius: 20,
                                                  child: Icon(
                                                    Icons.person,
                                                    color: AppColors.whitecolor,
                                                    size: 30,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.height * 0.015,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      widget.view.title!,
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: AppColors
                                                              .whitecolor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      "Published ${newdate}",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: AppColors
                                                              .whitecolor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: Get.height * 0.058,
                                            width: Get.width * 0.35,
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        widget
                                                            .view.totalComments
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: AppColors
                                                                .whitecolor),
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.01,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .mode_comment_rounded,
                                                        color: AppColors
                                                            .whitecolor,
                                                        size: 20,
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        widget.view.totalLikes
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: AppColors
                                                                .whitecolor),
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.01,
                                                      ),
                                                      Icon(
                                                        Icons.favorite,
                                                        color: AppColors
                                                            .favouritecolor,
                                                        size: 20,
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        widget.view.totalViews
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: AppColors
                                                                .whitecolor),
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.01,
                                                      ),
                                                      Icon(
                                                        Icons.person,
                                                        color: AppColors
                                                            .primaryColor,
                                                        size: 20,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.01),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Comments",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.whitecolor),
                                  ),
                                ),
                                Container(
                                  height: Get.height * 0.327,
                                  width: Get.width * 0.95,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: ListView.builder(
                                        itemCount: widget.comments.length,
                                        itemBuilder: (context, int index) {
                                          Comment usercomment =
                                              widget.comments[index];

                                          return Container(
                                            height: Get.height * 0.06,
                                            width: Get.width * 0.95,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: AppColors
                                                            .whitecolor,
                                                        width: 1.5))),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 7),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(AppUrl
                                                                  .imageUrl +
                                                              usercomment
                                                                  .user!.profile
                                                                  .toString()),
                                                      radius: 20,
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.04,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              usercomment
                                                                  .user!.name
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: AppColors
                                                                      .whitecolor),
                                                            ),
                                                            SizedBox(
                                                              width: Get.width *
                                                                  0.015,
                                                            ),
                                                            Text(
                                                              "20 Days Ago",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .whitecolor),
                                                            ),
                                                            SizedBox(
                                                              width: Get.width *
                                                                  0.02,
                                                            ),
                                                            Icon(
                                                              Icons.favorite,
                                                              color: AppColors
                                                                  .favouritecolor,
                                                              size: 15,
                                                            )
                                                          ],
                                                        ),
                                                        Text(
                                                          usercomment.comment
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .whitecolor),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
              ),
            )),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.replay_10,
                size: 35,
              ),
              color: AppColors.primaryColor,
              onPressed: () {
                final currentPosition = controller.value.position;
                final newPosition = currentPosition - Duration(seconds: 10);
                controller.seekTo(newPosition);
              },
            ),
            GestureDetector(
              onTap: () {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
              },
              child: Icon(
                controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: AppColors.primaryColor,
                size: 75.0,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.forward_10,
                size: 35,
              ),
              color: AppColors.primaryColor,
              onPressed: () {
                final currentPosition = controller.value.position;
                final newPosition = currentPosition + Duration(seconds: 10);
                controller.seekTo(newPosition);
              },
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 75),
          child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(
                Icons.fullscreen,
                size: 40,
              ),
              color: AppColors.primaryColor,
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: VideoTimer(controller: controller),
        ),
      ],
    );
  }
}

class VideoTimer extends StatelessWidget {
  final VideoPlayerController controller;

  VideoTimer({required this.controller});

  String _formatDuration(Duration duration) {
    return "${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final position = controller.value.position;
    final duration = controller.value.duration;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _formatDuration(position),
          style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
        ),
        Text(
          _formatDuration(duration),
          style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
        ),
      ],
    );
  }
}
