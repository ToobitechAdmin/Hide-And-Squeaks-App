import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioModel {
  Icon play;
  String title;
  String time;
  int treats;
  Icon download;
  Icon bin;



  // Constructor
  AudioModel({
    required this.play,
    required this.title,
    required this.time,
    required this.treats,
    required this.download,
    required this.bin

  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      play: json['play'],
      title: json['title'],
      time: json['time'],
      treats: json['treats'],
      download: json['download'],
      bin: json["bin"]

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'play': play,
      'title': title,
      'time': time,
      "treats":treats,
      "download":download,
      "bin":bin

    };
  }



}