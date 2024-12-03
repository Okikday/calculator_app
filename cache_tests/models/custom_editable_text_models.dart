import 'package:flutter/material.dart';

class CustomTextElementModel {
  final String text;
  final Map<Alignment, String>? extraTexts;
  final TextStyle textStyle;

  CustomTextElementModel({
    required this.text,
    this.extraTexts,
    this.textStyle = const TextStyle(
      fontSize: 100 * 0.8,
      color: Colors.white,
    ),
  });

  CustomTextElementModel copyWith({
    String? text,
    Map<Alignment, String>? extraTexts,
    List<Alignment>? extraTextsPlacements,
    TextStyle? textStyle,
  }) {
    return CustomTextElementModel(
      text: text ?? this.text,
      extraTexts: extraTexts,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  factory CustomTextElementModel.fromJson(Map<String, dynamic> json) {
    return CustomTextElementModel(
      text: json['text'] as String,
      extraTexts: json['extraTexts'] as Map<Alignment, String>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'extraTexts': extraTexts,
    };
  }
}

class CursorModel {
  final double width;
  final double height;
  final Color color;

  CursorModel({this.width = 2, required this.height, this.color = Colors.orange});
}
