
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
class Comment {
  final int? id;
  final String comment;
  final int? userId;
  final int? videoId;
  final String? createdAt;
  final String? updatedAt;
  User?user;

  Comment({
    this.id,
    required this.comment,
    required this.userId,
    this.videoId,
    this.createdAt,
    this.updatedAt,
    this.user
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      comment: json['comment'],
      userId: json['user_id'],
      videoId: json['video_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
    );
  }
}
class User {
  int id;
  String name;
  String profile;

  User({required this.id, required this.name, required this.profile});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      profile: json['profile'],
    );
  }
  
  
}
