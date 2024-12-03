import 'dart:developer';
import 'dart:math' as math;
import 'package:calculator_app/common/constant_widgets.dart';
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

  static Widget makeCursorWidget(CursorModel cursor) {
    return Animate(
      child: Container(
        width: cursor.width,
        height: cursor.height * 0.95,
        color: cursor.color,
      ),
    ).slideX();
  }

static Widget? makeSpecialTextWidget(BuildContext context, CustomTextElementModel content,) {
  if (content.extraTexts == null || content.extraTexts!.isEmpty) return null;

  final Map<Alignment, String> extraTexts = content.extraTexts!;
  final double normalFontSize = content.textStyle.fontSize ?? 100 * 0.8; 
  
  final double smallBoxSize = normalFontSize * 0.3;
  final Color textColor = content.textStyle.color ?? Colors.orange;

  Widget alignmentTextWidget({
    required Alignment alignment,
  }) {
    return ColoredBox(
      color: Colors.orange,
      child: SizedBox(
        width: smallBoxSize,
        height: smallBoxSize,
        child: extraTexts.containsKey(alignment)
            ? Center(
              child: ConstantWidgets.text(
                context,
                extraTexts[alignment]!,
                fontSize: smallBoxSize * 0.8,
                color: textColor,
              ),
            )
            : null, 
      ),
    );
  }

  return ColoredBox(
    color: Colors.green,
    child: Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        ConstantWidgets.text(
          context,
          content.text,
          fontSize: normalFontSize,
          color: textColor,
        ),
        Stack(
          children: [
            SizedBox(height: normalFontSize, width: normalFontSize,),
            
          ],
        )
      ],
    ),
  );

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
    required double cursorWidth,
  }) {
    // Early return for empty list or invalid input
    if (textWidths.isEmpty) return 0;

    // Adjust tap position considering scroll offset
    final adjustedTapX = tapOffset.dx + scrollOffset;

    // Calculate total text width
    final totalTextWidth = textWidths.fold(0.0, (sum, width) => sum + width);

    // Handle cases where tap is outside the text bounds
    if (adjustedTapX <= 0) return 0;
    if (adjustedTapX >= totalTextWidth) return textWidths.length;

    double cumulativeWidth = 0.0;

    // Special handling for the last characters
    final int lastFullCharIndex = textWidths.length - 1;
    final int startCheckIndex = math.max(0, lastFullCharIndex - 10); // Check last 10 characters more carefully

    for (int i = 0; i < textWidths.length; i++) {
      final charWidth = textWidths[i];

      // Determine the start and end of the current character
      final charStart = cumulativeWidth;
      final charEnd = cumulativeWidth + charWidth;

      // Adjust precision for the last characters
      double tolerance = i >= startCheckIndex ? 3.0 : 1.0;

      // Check if the tap is within this character's bounds with tolerance
      if (adjustedTapX >= charStart - tolerance && adjustedTapX <= charEnd + tolerance) {
        // More nuanced midpoint calculation for last characters
        double charMidpoint;
        if (i >= startCheckIndex) {
          // For last characters, bias towards the end slightly
          charMidpoint = charStart + (charWidth * 0.6);
        } else {
          charMidpoint = charStart + (charWidth / 2);
        }

        if (adjustedTapX < charMidpoint) {
          return i; // Cursor is to the left of the current character
        } else {
          return i + 1; // Cursor is to the right of the current character
        }
      }

      // Move cumulative width forward
      cumulativeWidth += charWidth;
    }

    // Fallback for edge cases
    if (adjustedTapX >= totalTextWidth - (cursorWidth * 2)) {
      return textWidths.length;
    }

    // Final fallback
    return textWidths.length;
  }
}
