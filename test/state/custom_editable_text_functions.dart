import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/custom_editable_text_models.dart';

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

  static Widget makeCursorWidget(CursorModel cursor){
    return Animate(
      child: Container(
        width: cursor.width,
        height: cursor.height * 0.95,
        color: cursor.color,
      ),
    ).slideX();
  }

  Widget makeSpecialTextWidget({required Map<String, dynamic> content}) {
    return SizedBox();
  }

  static Offset getCursorPosition({
  required Offset tapOffset,
  required List<double> textWidths,
  required double containerHeight,
  required double scrollOffset,
  required double containerWidth,
}) {
  double cumulativeWidth = 0;

  // Adjust the tapOffset.dx by adding the scrollOffset
  double adjustedTapX = tapOffset.dx + scrollOffset;

  for (int i = 0; i < textWidths.length; i++) {
    final elementWidth = textWidths[i];

    // Check if the adjusted tap is within the bounds of the current text element
    if (adjustedTapX <= cumulativeWidth + elementWidth) {
      final charStart = cumulativeWidth;
      final charMid = cumulativeWidth + elementWidth / 2;
      final charEnd = cumulativeWidth + elementWidth;

      // Determine whether to snap to the left or right side
      double cursorX;
      if (adjustedTapX <= charMid) {
        cursorX = (charStart - scrollOffset).clamp(0.0, containerWidth - (containerWidth * 0.01));
      } else {
        cursorX = (charEnd - scrollOffset).clamp(0.0, containerWidth - (containerWidth * 0.01));
      }

      return Offset(cursorX, containerHeight * 0.05);
    }

    cumulativeWidth += elementWidth;
  }

  // Default: Place the cursor at the end of the visible range
  double cursorX = (cumulativeWidth - scrollOffset).clamp(0.0, containerWidth - (containerWidth * 0.01));
  return Offset(cursorX, containerHeight * 0.05);
}

static int getCursorOffset({
  required List<double> textWidths,
  required double scrollOffset,
  required double containerWidth,
  required Offset tapOffset,
}) {
  if (textWidths.isEmpty) return 0;

  double cumulativeWidth = 0.0;
  final adjustedTapX = tapOffset.dx + scrollOffset;

  for (int i = 0; i < textWidths.length; i++) {
    cumulativeWidth += textWidths[i];

    if (cumulativeWidth >= adjustedTapX) {
      final charStart = cumulativeWidth - textWidths[i];
      final charMid = charStart + textWidths[i] / 2;

      if (adjustedTapX <= charMid) {
        return i; // Cursor on the left part of the character
      } else {
        return (i + 1).clamp(0, textWidths.length); // Cursor on the right part of the character
      }
    }
  }

  // Special case: Tap is beyond the last character
  return textWidths.length;
}


}
