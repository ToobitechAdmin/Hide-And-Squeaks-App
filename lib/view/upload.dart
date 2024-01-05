import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';
import 'package:squeak/view/comment.dart';
import 'package:squeak/view/socialfeed.dart';
import 'package:squeak/view/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:chunked_uploader/chunked_uploader.dart';

import '../components/colors.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool isChecked = false;
  bool isChecked2 = false;
  bool showSelectAnotherVideo = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 1,
        width: Get.width * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.backgroundmain), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: Get.height * 0.45,
                        width: Get.width * 1,
                        decoration: BoxDecoration(color: Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: CustomBar(midtext: "Upload"),
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Title",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor),
                      ),
                    ),

                    TextFormField(
                      controller: _titleController,
                      textAlign: TextAlign.start,
                      cursorColor: AppColors.whitecolor,
                      style: TextStyle(
                        color: AppColors.whitecolor,
                        fontSize: 17,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none, // Set the border to none
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.whitecolor, width: 2)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.whitecolor,
                                width: 2), // Change color as needed
                          ),
                          focusColor: Colors.transparent,
                          hintStyle: TextStyle(
                            fontSize: 17,
                            color: AppColors.whitecolor,
                            fontWeight: FontWeight.w400,
                          ),
                          constraints: BoxConstraints.tightFor(
                              height: Get.height * 0.035)),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryColor),
                      ),
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      textAlign: TextAlign.start,
                      cursorColor: AppColors.whitecolor,
                      style: TextStyle(
                        color: AppColors.whitecolor,
                        fontSize: 17,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none, // Set the border to none
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.whitecolor, width: 2)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.whitecolor,
                                width: 2), // Change color as needed
                          ),
                          focusColor: Colors.transparent,
                          hintStyle: TextStyle(
                            fontSize: 17,
                            color: AppColors.whitecolor,
                            fontWeight: FontWeight.w400,
                          ),
                          constraints: BoxConstraints.tightFor(
                              height: Get.height * 0.035)),
                    ),
                    // Container(
                    //   width: Get.width*0.88,
                    //   decoration: BoxDecoration(
                    //       border: Border(
                    //           bottom: BorderSide(
                    //               color: Customitems.whitecolor,
                    //               width: 2.5
                    //           )
                    //       )
                    //   ),
                    // ),

                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    if (showSelectAnotherVideo)
                      Container(
                        color: Colors.transparent, // Use your color
                        height: Get.height * 0.085, // Adjust as per your design
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.add_box_outlined, // Your icon here
                                color: AppColors.primaryColor,
                                size: 85,
                                weight: 10,
                              ),
                              SizedBox(
                                width: Get.width * 0.05,
                              ),
                              Text(
                                'Select another Video',
                                style: TextStyle(
                                    color: AppColors.whitecolor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                      ),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showSelectAnotherVideo = true;
                        });
                      },
                      child: Stack(children: [
                        Container(
                          height: Get.height * 0.1,
                          width: Get.width * 0.89,
                          decoration: BoxDecoration(color: Colors.transparent),
                        ),
                        Positioned(
                          right: 0,
                          top: 11,
                          child: CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            radius: 40,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: Get.height * 0.067,
                            width: Get.width * 0.89,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.primaryColor),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Upload Video",
                                    style: TextStyle(
                                        color: AppColors.whitecolor,
                                        fontSize: 27,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.1,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Icon(
                                      Icons.file_upload_outlined,
                                      size: 50,
                                      weight: 50,
                                      color: AppColors.whitecolor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.to(CommentScreen());
                      },
                      child: Container(
                        height: Get.height * 0.055,
                        width: Get.width * 0.31,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppAssets.plublish),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.022,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: Get.height * 0.028,
                              width: Get.width * 0.063,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.whitecolor,
                                  width: 2,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                },
                                child: Center(
                                  child: isChecked
                                      ? Icon(
                                          Icons.check,
                                          color: AppColors
                                              .primaryColor, // Set checkmark color to transparent
                                        )
                                      : SizedBox
                                          .shrink(), // Empty space when not checked
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.03,
                            ),
                            Text(
                              "PRIVATE",
                              style: TextStyle(
                                  color: AppColors.whitecolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Container(
                          height: Get.height * 0.037,
                          width: Get.width * 0.0000001,
                          decoration: BoxDecoration(
                              border: Border(
                                  right:
                                      BorderSide(color: AppColors.whitecolor))),
                        ),
                        Row(
                          children: [
                            Container(
                              height: Get.height * 0.028,
                              width: Get.width * 0.063,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.whitecolor,
                                  width: 2,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isChecked2 = !isChecked2;
                                  });
                                },
                                child: Center(
                                  child: isChecked2
                                      ? Icon(
                                          Icons.check,
                                          color: AppColors
                                              .primaryColor, // Set checkmark color to transparent
                                        )
                                      : SizedBox
                                          .shrink(), // Empty space when not checked
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.03,
                            ),
                            Text(
                              "PUBLIC",
                              style: TextStyle(
                                  color: AppColors.whitecolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
