import 'package:flutter/material.dart';

class CustomTextElementModel {
  final String text;
  final List<String>? extraTexts;
  final List<Alignment>? extraTextsPlacements;
  final TextStyle textStyle;

  CustomTextElementModel({
    required this.text,
    this.extraTexts,
    this.extraTextsPlacements,
    this.textStyle = const TextStyle(fontSize: 100 * 0.8, color: Colors.white,),
  });

  factory CustomTextElementModel.fromJson(Map<String, dynamic> json) {
    return CustomTextElementModel(
      text: json['text'] as String,
      extraTexts: json['extraTexts'] as List<String>?,
      extraTextsPlacements: json['extraTextsPlacements'] as List<Alignment>?,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'text': text,
      'extraTexts': extraTexts,
      'extraTextsPlacements': extraTextsPlacements,
    };
  }
}