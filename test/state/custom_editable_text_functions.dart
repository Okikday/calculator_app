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
        // Ensure the cursor position is clamped within visible bounds
        double cursorX = (cumulativeWidth - scrollOffset).clamp(0.0, containerWidth);
        return Offset(cursorX, containerHeight * 0.05);
      }

      cumulativeWidth += elementWidth;
    }

    // Default: Place the cursor at the end of the visible range
    double cursorX = (cumulativeWidth - scrollOffset).clamp(0.0, containerWidth);
    return Offset(cursorX, containerHeight * 0.05);
  }

static void handlePointerMovement(
    Offset tapOffset, 
    ScrollController scrollController, 
    double containerWidth,
    List<double> textWidths,
) {
  const double edgeThreshold = 40.0; // Distance from edges to start scrolling
  const double scrollAmount = 10.0; // Amount to scroll per tick

  // Calculate the total width of all text elements
  final totalTextWidth = textWidths.fold(0.0, (sum, width) => sum + width);

  if (tapOffset.dx < edgeThreshold) {
    // Near the left edge, scroll left
    final targetOffset = (scrollController.offset - scrollAmount - edgeThreshold/2).clamp(0.0, totalTextWidth - containerWidth);
    scrollController.jumpTo(targetOffset);
  } else if (tapOffset.dx > containerWidth - edgeThreshold) {
    // Near the right edge, scroll right
    final maxOffset = (totalTextWidth - containerWidth - edgeThreshold/2).clamp(0.0, double.infinity);
    final targetOffset = (scrollController.offset + scrollAmount).clamp(0.0, maxOffset);
    scrollController.jumpTo(targetOffset + edgeThreshold);

    // Handle the case where the last text element on the right is encountered
    if (scrollController.offset >= maxOffset - scrollAmount) {
      customEditableTextController.setCursorPosition(const Offset(380, 0));
    }
  } else {
    // Ensure the offset stays within bounds
    final targetOffset = scrollController.offset.clamp(0.0, totalTextWidth - containerWidth);
    scrollController.jumpTo(targetOffset);
  }
}





// static void ensureCursorVisibility({
//   required double cursorX,
//   required ScrollController scrollController,
//   required double containerWidth,
// }) {
//   // Calculate the cursor's position relative to the visible area
//   final visibleStart = scrollController.offset;
//   final visibleEnd = scrollController.offset + containerWidth;

//   if (cursorX < visibleStart) {
//     // Cursor is out of view to the left, scroll left
//     scrollController.jumpTo(cursorX.clamp(0.0, scrollController.position.maxScrollExtent));
//   } else if (cursorX > visibleEnd) {
//     // Cursor is out of view to the right, scroll right
//     scrollController.jumpTo((cursorX - containerWidth).clamp(0.0, scrollController.position.maxScrollExtent));
//   }
// }


}
