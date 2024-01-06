import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class userModel{
  String? id;
  String petName;
  String petBreed;
  String profile;

  userModel({
    this.id,
    required this.petName,
    required this.petBreed,
    required this.profile});

    factory userModel.fromJson(Map<String, dynamic> json) {
    return userModel(
      id:json["id"],
      petName: json['pet_name'] ,
      petBreed: json['pet_breed'],
      profile: json['profile'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id":id,
      'pet_name': petName,
      'pet_breed': petBreed,
      'profile': profile,
      
    };
  }



}