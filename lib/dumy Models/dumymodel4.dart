import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridModel1 {
  String img;
  String title;
  String comment;
  String favourite;





  // Constructor
  GridModel1({
    required this.img,
    required this.title,
    required this.comment,
    required this.favourite,



  });

  factory GridModel1.fromJson(Map<String, dynamic> json) {
    return GridModel1(
      img: json['img'],
      title: json['title'],
      comment: json['comment'],
      favourite: json['favourite'],




    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
      'title': title,
      "comment":comment,
      "favourite":favourite




    };
  }



}