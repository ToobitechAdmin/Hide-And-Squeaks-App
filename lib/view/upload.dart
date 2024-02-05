

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squeak/components/app_assets.dart';
import 'package:squeak/components/custom.dart';
import 'package:squeak/components/snakbar.dart';
import 'package:squeak/controller/video_controller.dart';
import 'package:squeak/models/video_model.dart';

import '../components/colors.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  VideoController controller = Get.put(VideoController());


  bool isChecked = false;
  bool isChecked2 = false;
  String privacyOption = "";
  
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _videokey = GlobalKey<FormState>();
  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter title';
    }
    return null;
  }

  String? validateDesc(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Description';
    }
    return null;
  }

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
                      Obx(
                        () => Container(
                          height: Get.height * 0.5,
                          width: Get.width * 1,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(
                                  image: controller.thumbnailFile.value != null
                                      ? Image.file(
                                              controller.thumbnailFile.value!)
                                          .image
                                      : AssetImage(AppAssets.defaultimg),
                                  fit: BoxFit.cover)),
                        ),
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
                child: Form(
                  key: _videokey,
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
                        validator: validateTitle,
                        textAlign: TextAlign.start,
                        cursorColor: AppColors.whitecolor,
                        style: TextStyle(
                          color: AppColors.whitecolor,
                          fontSize: 17,
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 3.5, vertical: 7),
                            hintText: "Enter Title of Your Video",
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
                              color: AppColors.whitecolor.withOpacity(0.5),
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
                        validator: validateDesc,
                        textAlign: TextAlign.start,
                        cursorColor: AppColors.whitecolor,
                        style: TextStyle(
                          color: AppColors.whitecolor,
                          fontSize: 17,
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 3.5, vertical: 7),
                            hintText: "Enter Description of Your Video",
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
                              color: AppColors.whitecolor.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                            ),
                            constraints: BoxConstraints.tightFor(
                                height: Get.height * 0.035)),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      
                        
                      GestureDetector(
                        onTap: () {
                          setState(() {
                          
                          });
                          print("pick video");

                          controller.pickVideo();
                        },
                        child: Stack(children: [
                          Container(
                            height: Get.height * 0.1,
                            width: Get.width * 0.89,
                            decoration:
                                BoxDecoration(color: Colors.transparent),
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
                          print("videopath:${controller.videofile.value}");
                          print("Privacy:  ${privacyOption}");
                          print( "Thumbnailpath ${controller.thumbnailFile.value}");
                          
                         

                          if (_videokey.currentState?.validate() ?? false) {
                            if (controller.videofile.value != null
                                ) {
                              var model = VideoModel(
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                  videotype: privacyOption,
                                  thumbnail: controller.thumbnailFile.value!.path
                            ,
                                  file_path: controller.videofile.value!.path
                                      );
                              controller.postVideo(model);
                            } else if (controller.videofile.value == null) {
                              showInSnackBar("Select a video to upload",
                                  color: AppColors.errorcolor);
                            
                            } else {
                              showInSnackBar("Select video Type",
                                  color: AppColors.errorcolor);
                            }
                          }
                          // _titleController.clear();
                          // _descriptionController.clear();
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
                        height: Get.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                checkColor: AppColors.primaryColor,
                                activeColor: Colors.transparent,
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value ?? false;
                                    isChecked2 = !isChecked;
                                    privacyOption = "private";
                                  });
                                },
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
                                    right: BorderSide(
                                        color: AppColors.whitecolor))),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                checkColor: AppColors.primaryColor,
                                activeColor: Colors.transparent,
                                value: isChecked2,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked2 = value ?? false;
                                    isChecked = !isChecked2;
                                    privacyOption = "public";
                                  });
                                },
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
