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
      if (i == textWidths.length - 1) {
        // If in the right half of the last character, snap to the end position
        if (adjustedTapX > cumulativeWidth + elementWidth / 2) {
          double cursorX = (cumulativeWidth + elementWidth - scrollOffset)
              .clamp(0.0, containerWidth - (containerWidth * 0.01));
          return Offset(cursorX, containerHeight * 0.05);
        }
      }

      // Otherwise, position the cursor normally
      double cursorX = (cumulativeWidth - scrollOffset).clamp(0.0, containerWidth - (containerWidth * 0.01));
      return Offset(cursorX, containerHeight * 0.05);
    }

    cumulativeWidth += elementWidth;
  }

  // Default: Place the cursor at the end of the visible range
  double cursorX = (cumulativeWidth - scrollOffset).clamp(0.0, containerWidth - (containerWidth * 0.01));
  return Offset(cursorX, containerHeight * 0.05);
}




  // static Offset getCursorPosition({
  //   required Offset tapOffset,
  //   required List<double> textWidths,
  //   required double containerHeight,
  //   required double scrollOffset,
  //   required double containerWidth,
  // }) {
  //   double cumulativeWidth = 0;

  //   // Adjust the tapOffset.dx by adding the scrollOffset
  //   double adjustedTapX = tapOffset.dx + scrollOffset;

  //   for (int i = 0; i < textWidths.length; i++) {
  //     final elementWidth = textWidths[i];

  //     // Check if the adjusted tap is within the bounds of the current text element
  //     if (adjustedTapX <= cumulativeWidth + elementWidth) {
  //       // Ensure the cursor position is clamped within visible bounds
  //       double cursorX = (cumulativeWidth - scrollOffset).clamp(0.0, containerWidth);
  //       return Offset(cursorX, containerHeight * 0.05);
  //     }

  //     cumulativeWidth += elementWidth;
  //   }

  //   // Default: Place the cursor at the end of the visible range
  //   double cursorX = (cumulativeWidth - scrollOffset).clamp(0.0, containerWidth);
  //   return Offset(cursorX, containerHeight * 0.05);
  // }

  static void handlePointerMovement(
    Offset tapOffset,
    ScrollController scrollController,
    double containerWidth,
    List<double> textWidths,
  ) {
    // Calculate the total width of all text elements
    final totalTextWidth = textWidths.fold(0.0, (sum, width) => sum + width);
    final double edgeThreshold = containerWidth * 0.1; // Distance from edges to start scrolling
    final double scrollAmount = totalTextWidth/textWidths.length; // Amount to scroll per tick, that is average
    final maxOffset = (totalTextWidth - containerWidth + edgeThreshold / 2).clamp(0.0, double.infinity);

    void scrollAnimateTo(double value) => scrollController.animateTo(value, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);

    if (tapOffset.dx <= edgeThreshold) {
      // Near the left edge, scroll left
      final targetOffset = (scrollController.offset - scrollAmount).clamp(0.0, totalTextWidth - containerWidth < 0 ? 1.0 : totalTextWidth - containerWidth);
      
      // Ensure visibility of the cursor at the beginning
      if (targetOffset.truncate() <= 0.0.truncate()) {
        // Align the cursor to the beginning of the visible area
        if (scrollController.offset <= edgeThreshold/2) {
          customEditableTextController.setCursorPosition(Offset.zero);
        } else {
          customEditableTextController.setCursorPosition(Offset.zero);
          scrollAnimateTo(0);
        }
      } else {
        scrollAnimateTo(0);
      }
    } else if (tapOffset.dx >= containerWidth - edgeThreshold) {
      log("maxScrollExtent: ${scrollController.position.maxScrollExtent}");
      // Near the right edge, scroll right
      // Adjust maxOffset to ensure the last character and cursor are fully visible
      final targetOffset = (scrollController.offset + scrollAmount).clamp(0.0, maxOffset);

      // Ensure visibility of the cursor at the end
      if (targetOffset >= maxOffset) {
        // Align the cursor to the end of the visible area
        if (maxOffset >= scrollController.position.maxScrollExtent) {
          customEditableTextController.setCursorPosition(Offset(containerWidth - (containerWidth * 0.01), 0));
          if(scrollController.offset != scrollController.position.maxScrollExtent){
            scrollAnimateTo(maxOffset);
          }
        } else {
          customEditableTextController.setCursorPosition(Offset(containerWidth - (containerWidth * 0.01), 0));
          scrollAnimateTo(maxOffset);
        }
      } else {
        scrollAnimateTo(maxOffset);
        
      }
    } else {
      
        // Ensure the offset stays within bounds
      final targetOffset = scrollController.offset.clamp(0.0, totalTextWidth - containerWidth < 0 ? 1.0 : totalTextWidth - containerWidth);
      scrollAnimateTo(targetOffset);
      
    }
  }

  /// Calculates the cursor offset based on the text widths, tap position, and visible container dimensions.
  static int getCursorOffset({
    required List<double> textWidths,
    required double scrollOffset,
    required double containerWidth,
    required Offset tapOffset,
  }) {
    if(textWidths.isEmpty) return 0;
    
    double cumulativeWidth = 0.0;

    // Adjust the tap position to account for the scroll offset
    final adjustedTapX = tapOffset.dx + scrollOffset;
    
    for (int i = 0; i < textWidths.length; i++) {
      cumulativeWidth += textWidths[i];

      // Check if the adjusted tap position falls within the bounds of the current character
      if (cumulativeWidth >= adjustedTapX) {
        if(tapOffset.dx < textWidths[0]){
          return i;
        }
        return i+1; // Return the index of the character
      }
    }
    
    // If no match is found, default to the last character
    return textWidths.length - 1;
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
