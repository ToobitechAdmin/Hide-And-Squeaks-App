import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/dumy Models/dumymodel2.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';
import 'package:squeak/view/video_player.dart';

import '../components/colors.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: Get.height * 1,
        width: Get.width * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.backgroundmain), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.5,
                width: Get.width * 1,
                decoration: BoxDecoration(color: AppColors.pinkcolor),
                child: VideoPlayerScreen(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: Get.height * 0.037,
                          width: Get.width * 0.22,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(20)),
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
                        TextField(
                          textAlign: TextAlign.start,
                          cursorColor: AppColors.whitecolor,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.more_horiz,
                              color: AppColors.whitecolor,
                              size: 25,
                            ),
                            hintText: "Comment",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
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
                        Icon(
                          Icons.favorite_outlined,
                          color: AppColors.favouritecolor,
                          size: 30,
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
                                    color: AppColors.whitecolor, width: 1))),
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
                                      backgroundColor: AppColors.primaryColor,
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
                                          "Lorem Ipsum",
                                          style: TextStyle(
                                              color: AppColors.whitecolor,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "Published 14 January 2019",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors.whitecolor,
                                              fontWeight: FontWeight.w500),
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "1",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: AppColors.whitecolor),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.01,
                                          ),
                                          Icon(
                                            Icons.mode_comment_rounded,
                                            color: AppColors.whitecolor,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "45",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: AppColors.whitecolor),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.01,
                                          ),
                                          Icon(
                                            Icons.favorite,
                                            color: AppColors.favouritecolor,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "5",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: AppColors.whitecolor),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.01,
                                          ),
                                          Icon(
                                            Icons.person,
                                            color: AppColors.primaryColor,
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
                            fontSize: 15, color: AppColors.whitecolor),
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
                            itemCount: share.length,
                            itemBuilder: (context, int index) {
                              CommentModel comments = share[index];
                              return Container(
                                height: Get.height * 0.06,
                                width: Get.width * 0.95,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppColors.whitecolor,
                                            width: 1.5))),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 7),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.black,
                                            size: 25,
                                          ),
                                          backgroundColor: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.04,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  comments.username,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          AppColors.whitecolor),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.015,
                                                ),
                                                Text(
                                                  comments.time,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColors.whitecolor),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.02,
                                                ),
                                                Icon(
                                                  Icons.favorite,
                                                  color: AppColors.favouritecolor,
                                                  size: 15,
                                                )
                                              ],
                                            ),
                                            Text(
                                              comments.comment,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.whitecolor),
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
      ),
    ));
  }
}
