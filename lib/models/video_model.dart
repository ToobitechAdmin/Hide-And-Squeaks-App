import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VideoModel {
  int? id;
  int? user_id;
  String? title;
  String? description;
  String? file_path;
  String? created_at;
  List? comments;
  List? likes;
  List? views;
  int? totalComments;
  int? totalLikes;
  int? totalViews;
  String? videotype;
  String? thumbnail;
  String? updated_at;
  bool? userLikedVideo;
  


  int? video_id;

  // Constructor
  VideoModel(
      {this.id,
      this.user_id,
      this.file_path,
      this.description,
      this.title,
      this.created_at,
      this.comments,
      this.likes,
      this.views,
      this.totalComments,
      this.totalLikes,
      this.totalViews,
      this.videotype,
      this.thumbnail,
      this.updated_at,
      this.userLikedVideo,
  
      this.video_id});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
     id: json['id'] as int?,
    user_id: json['user_id'] as int?,
    file_path: json['file_path'] as String? ?? '',
    title: json['title'] as String? ?? '',
    videotype: json["video_type"] as String? ?? '',
    description: json['description'] as String? ?? '',
    created_at: json['created_at'] as String? ?? '',
    updated_at: json['updated_at'] as String? ?? '',
    comments: (json['comments'] as List<dynamic>?)
        ?.map((comment) => VideoModel.fromJson(comment))
        .toList(),
    likes: (json['likes'] as List<dynamic>?)
        ?.map((like) => VideoModel.fromJson(like))
        .toList(),
    views: (json['views'] as List<dynamic>?)
        ?.map((view) => VideoModel.fromJson(view))
        .toList(),
    totalComments: json['total_comments'] as int?,
    totalLikes: json['total_likes'] as int?,
    totalViews: json['total_views'] as int?,
    thumbnail: json["thumbnail_path"] as String? ?? '',
    video_id: json['video_id'] as int?,
    userLikedVideo: json["userLikedVideo"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "user_id":user_id,
      'file_path': file_path,
      'title': title,
      "description": description,
      "created_at": created_at,
      "comments": comments,
      "likes": likes,
      "views": views,
      "total_comments": totalComments,
      "totalLikes": totalLikes,
      "total_views": totalViews,
      "video_type": videotype,
      "thumbnail": thumbnail,
      "userLikedVideo":userLikedVideo
    };
  }
}
