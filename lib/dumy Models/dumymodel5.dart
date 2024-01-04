import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppModel {
  String img;
  String title;
  String price;






  // Constructor
  AppModel({
    required this.img,
    required this.title,
    required this.price,




  });

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      img: json['img'],
      title: json['title'],
      price: json['price'],





    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
      'title': title,
      "price":price,





    };
  }



}