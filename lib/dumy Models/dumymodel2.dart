import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentModel {
  String username;
  String time;
  String comment;
  String img;




  // Constructor
  CommentModel({
    required this.username,
    required this.time,
    required this.comment,
    required this.img


  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        comment: json['comment'],
        username: json['username'],
        time: json['time'],
      img: json["img"]



    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'username': username,
      'time': time,
      "img":img


    };
  }



}