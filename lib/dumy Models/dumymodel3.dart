import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TreatModel {
  String treats;
  String price;





  // Constructor
  TreatModel({
    required this.treats,
    required this.price,



  });

  factory TreatModel.fromJson(Map<String, dynamic> json) {
    return TreatModel(
        treats: json['treats'],
        price: json['price'],




    );
  }

  Map<String, dynamic> toJson() {
    return {
      'treats': treats,
      'price': price,



    };
  }



}