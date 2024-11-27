import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/custom_text_element_model.dart';
import 'custom_editable_text_controller.dart';

class CustomEditableTextFunctions {
  static Size measureTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(); // Layout the text to calculate size
    return textPainter.size; // Return both width and height as Size
  }

  static Widget makeNormalTextWidget({
    required CustomTextElementModel customText,
  }) {
    final Size textSize = measureTextSize(customText.text, customText.textStyle);
    // log("Text width: ${textSize.width}, Text height: ${textSize.height}, Text: ${customText.text}");

    return SizedBox(
      width: textSize.width,
      height: customText.textStyle.height,
      child: RichText(text: TextSpan(text: customText.text, style: customText.textStyle)),
    );
  }

  static Widget makeCursorWidget(double height){
    return Container(
      width: 2,
      height: height * 0.95,
      color: Colors.orange,
    );
  }

  Widget makeSpecialTextWidget({required Map<String, dynamic> content}) {
    return SizedBox();
  }

}
