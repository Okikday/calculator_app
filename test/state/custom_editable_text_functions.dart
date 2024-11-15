import 'dart:developer';

import 'package:flutter/material.dart';

class CustomEditableTextFunctions{
  
  static Size measureTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(); // Layout the text to calculate size
    return textPainter.size; // Return both width and height as Size
  }

  static Widget makeNormalTextWidget({required String text, required TextStyle textStyle,}) {
    final Size textSize = measureTextSize(text, textStyle);
    log("Text width: ${textSize.width}, Text height: ${textSize.height}, Text: $text");
    return SizedBox(
      width: textSize.width,
      height: textStyle.height,
      child: RichText(text: TextSpan(text: text, style: textStyle)),
    );
  }

  Widget makeSpecialTextWidget({required Map<String, dynamic> content}) {
    return SizedBox();
  }

  
}