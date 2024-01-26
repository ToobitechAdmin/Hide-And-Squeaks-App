// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:squeak/components/colors.dart';

import 'package:squeak/models/comment_model.dart';

import 'package:squeak/models/video_model.dart';
import 'package:squeak/view/socialfeed.dart';
import 'package:squeak/view/video_player.dart';
import '../App_URL/apiurl.dart';
import '../Local Storage/global_variable.dart';
import '../components/snakbar.dart';
import '../global/alertbox.dart';
import 'package:file_picker/file_picker.dart';

class VideoController extends GetxController {
  Rx<File?> selectedVideo = Rx<File?>(null);
  var isLoading = false.obs;

  pickVideo() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      selectedVideo.value = File(result.files.single.path!);
    }
  }

  Rx<File?> imagethumbnail = Rx<File?>(null);

  void pickThumb() async {
    try {
      final pickedthumb =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedthumb == null) {
        print('No thumb image picked.');
        return;
      }

      final imagethumbtemp = File(pickedthumb.path);

      imagethumbnail.value = imagethumbtemp;
      print(imagethumbnail.value);
    } catch (e) {
      print('Failed to pick Thumb: $e');
    }
  }

  RxBool uploading = false.obs;

  postVideo(VideoModel videodata) async {
    showDialogue();

    String currentToken = appStorage.read('userToken');

    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(AppUrl.PostVideoURL))
            ..headers['Authorization'] = 'Bearer $currentToken'
            ..headers['Accept'] = 'application/json'
            ..fields['title'] = videodata.title!
            ..fields['description'] = videodata.description!
            ..fields['video_type'] = videodata.videotype!
            ..files.add(await http.MultipartFile.fromPath(
              'file_path',
              selectedVideo.value!.path,
            ))
            ..files.add(await http.MultipartFile.fromPath(
              'thumbnail',
              imagethumbnail.value!.path,
            ));

      print(
        selectedVideo.value!.path,
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> responseData = json.decode(responseBody);
        Get.back();
        showInSnackBar("${responseData["message"]}",
            color: AppColors.greencolor);
        print(response.statusCode);
        print(responseData);
        if (selectedVideo.value != null) {
          selectedVideo.value = null;
        }
        if (imagethumbnail.value != null) {
          imagethumbnail.value = null;
        }

        {
          print(" ${responseData['message']}");
          Get.to(SocialScreen());
        }
      } else {
        final Map<String, dynamic> responseData =
            json.decode(await response.stream.bytesToString());

        print("Response: ${responseData["message"]}");
        if (responseData['success'] == false) {
          Get.back();

          print("Response: ${responseData["message"]}");
          showInSnackBar("${responseData["message"]}",
              color: AppColors.errorcolor);
        } else {
          Get.back();
          showInSnackBar("${responseData["message"]}",
              color: AppColors.errorcolor);
        }
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  List<VideoModel> videoListprivate = <VideoModel>[].obs;
  List<VideoModel> videoListpublic = <VideoModel>[].obs;

  Getvideo() async {
    String currentToken = appStorage.read('userToken');
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse(AppUrl.GetVideoURL),
        headers: {
          'Authorization': "Bearer  $currentToken ",
          'Accept': "application/json",
        },
      );
      if (response.statusCode == 200) {
      print(response.body);
      print("API call");
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['status'] == true) {
        if (responseData['data'] != null && responseData['data'].containsKey('public')) {
          var publicVideos = responseData['data']['public'] as List;

          final List<dynamic> videoDataList = publicVideos;
          

          for (var videoData in videoDataList) {
            print(videoData["id"]);
             print(videoData["title"]);
              print(videoData["user_id"]);
               print(videoData["file_path"]);
               print(videoData["thumbnail_path"]);
               print(videoData["likes_count"]);
               print(videoData["created_at]"]);
               print(videoData["comments_count"]);
              
               
            
            videoListpublic.add(VideoModel(
                title: videoData["title"],
                description:videoData["description"] ,
                file_path: videoData["filepath"],
                thumbnail: videoData["thumbnail_path"],
                created_at: videoData["created_at"],
                id: videoData["id"],
                totalLikes:videoData["likes_count"],
                totalComments: videoData["comments_count"],
                ));
          }
          print(videoListpublic.length);
        
        } 
        if (responseData['data'] != null && responseData['data'].containsKey('private')) {
          var privateVideos = responseData['data']['private'] as List;

          final List<dynamic> videoDataList = privateVideos;
          

          for (var videoData in videoDataList) {
            print(videoData["id"]);
             print(videoData["title"]);
              print(videoData["user_id"]);
               print(videoData["file_path"]);
               print(videoData["thumbnail_path"]);
               print(videoData["likes_count"]);
               print(videoData["created_at]"]);
               print(videoData["comments_count"]);
              
               
            
            videoListprivate.add(VideoModel(
                title: videoData["title"],
                description:videoData["description"] ,
                file_path: videoData["filepath"],
                thumbnail: videoData["thumbnail_path"],
                created_at: videoData["created_at"],
                id: videoData["id"],
                totalLikes:videoData["likes_count"],
                totalComments: videoData["comments_count"],
                ));
          }
          print(videoListprivate.length);
          
        } 
        isLoading.value = false;





      } 
    } 
    

       
    } catch (error) {
      print('Error during GET request: $error');
      isLoading.value = false;
    }
  }

  Addview(userid) async {
    String currentToken = appStorage.read('userToken');

    try {
      final response = await http.post(
        Uri.parse(AppUrl.addViewUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer  $currentToken ',
        },
        body: jsonEncode({
          'video_id': userid,
        }),
      );

      if (response.statusCode == 200) {
        if (response.body != null) {
         
          final dynamic responseData = json.decode(response.body);

         
          if (responseData is List<dynamic>) {
            for (var data in responseData) {
             
              final VideoModel postData = VideoModel.fromJson(data);
              print("title: ${postData.title}, id: ${postData.id}");
            }
          } else {
            print(responseData);
          }
        } else {
          print('Response body is null');
        }
      } else {
        print('POST request failed with status: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      print('Error during POST request: $error');
    }
  }

  RxInt total_likes = 0.obs;

  ViewData(userid) async {
    print(userid);
    print("View data API call");
    String currentToken = appStorage.read('userToken');

    try {
      final response = await http.post(
        Uri.parse(AppUrl.viewVideoURL),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer  $currentToken ',
        },
        body: jsonEncode({
          'video_id': userid,
        }),
      );

      if (response.statusCode == 200) {
       
        if (response.body != null) {
          final dynamic responseData = json.decode(response.body);

          if (responseData is List<dynamic>) {
            
          } else {
            print("data:${responseData}");

            print("user_id: ${responseData["data"]["video"]["user_id"]}");
            print("id: ${responseData["data"]["video"]["id"]}");
            print("created_at: ${responseData["data"]["video"]["created_at"]}");
            print("Totalviews: ${responseData["data"]["total_views"]}");
            print("TotalLikes: ${responseData["data"]["total_likes"]}");
            print("TotalComments: ${responseData["data"]["total_comments"]}");
            print(
                "Filepath: ${AppUrl.videoURL + responseData["data"]["video"]["file_path"]}");
            List<Comment> comments =
                (responseData['data']['video']['comments'] as List)
                    .map((commentJson) => Comment.fromJson(commentJson))
                    .toList();
            
           

            var videoViewData = VideoModel(
              id: responseData["data"]["video"]["id"],
              user_id: responseData["data"]["video"]["user_id"],
              title: responseData["data"]["video"]["title"],
              created_at: responseData["data"]["video"]["created_at"],
              file_path:
                  AppUrl.videoURL + responseData["data"]["video"]["file_path"],
              totalLikes: responseData["data"]["total_likes"],
              totalComments: responseData["data"]["total_comments"],
              totalViews: responseData["data"]["total_views"],
            );

            Get.to(VideoPlayerScreen(view: videoViewData,comments:comments));
          }
        } else {
          print('Response body is null');
        }
      } else {
        print('POST request failed with status: ${response.statusCode}');
        print(response.body);
      }
    } catch (error) {
      print('Error during POST request: $error');
    }
  }

  postComment(String comment, int videoId) async {
    String currentToken = appStorage.read('userToken');
    try {
      final response = await http.post(
        Uri.parse(AppUrl.commentUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer  $currentToken ',
        },
        body: jsonEncode({
          'comment': comment,
          'video_id': videoId,
        }),
      );
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        showInSnackBar(responseData["message"], color: AppColors.greencolor);
        print('Comment posted successfully');
        print('Response body: ${response.body}');
      } else {
        print('Error posting comment:${response.statusCode}');
        print('Error response body: ${response.body}');
      }
    } catch (e) {
      print('Exception during postComment: $e');
    }
  }

  postLike(int videoId) async {
    String currentToken = appStorage.read('userToken');
    try {
      final response = await http.post(
        Uri.parse(AppUrl.likeUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer  $currentToken ',
        },
        body: jsonEncode({
          'video_id': videoId,
        }),
      );
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        showInSnackBar(responseData["message"], color: Colors.pink);
        print('Like posted successfully');
        print('Response body: ${response.body}');
      } else {
        print('Error posting Like. Status code: ${response.statusCode}');
        print('Error response body: ${response.body}');
      }
    } catch (e) {
      print('Exception during postLike: $e');
    }
  }

  deleteVideo(int videoId) async {
    print(videoId);
    String currentToken = appStorage.read('userToken');
    try {
      

      final response = await http.post(
        Uri.parse(AppUrl.videoDelUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer  $currentToken',
        },
        body: jsonEncode({
          'video_id': videoId,
        }),
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        showInSnackBar(responseData["message"], color: AppColors.greencolor);

        print(response.statusCode);
        print(responseData);
        print("Video Deleted Successfully");
        // Getvideo();
      } else {
        print(response.statusCode);
        showInSnackBar(responseData["message"], color: AppColors.errorcolor);
      }
    } catch (error) {
      print('Error deleting data: $error');
    }
  }
}
