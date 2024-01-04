import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:squeak/dumy Models/dumymodel5.dart';
import 'package:squeak/components/custom.dart';

class ApiService{
  final String baseUrl;

  ApiService({required this.baseUrl});
  Future<List<AppModel>> getPost()async{
    final response=await http.get(Uri.parse("$baseUrl/app"));

    if(response.statusCode==200){
      final List<dynamic> data=json.decode(response.body);
      return data.map((json) => AppModel.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to load posts');
    }

  }




}