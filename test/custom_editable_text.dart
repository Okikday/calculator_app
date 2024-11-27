import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'state/custom_editable_text_controller.dart';
import 'state/custom_editable_text_functions.dart';

class CustomEditableText extends StatelessWidget {
  final double height;
  final double width;
  final TextStyle textStyle;

  const CustomEditableText({
    super.key,
    this.height = 100,
    this.width = 400,
    this.textStyle = const TextStyle(
      fontSize: 100 * 0.8,
      color: Colors.white,
    ),
  });

  @override
  Widget build(BuildContext context) {
    customEditableTextController.setContainerSize(Size(width, height));

    return Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue.withOpacity(0.1),
        ),
        height: height,
        width: width,
        clipBehavior: Clip.hardEdge,
        child: Obx(
          () => GestureDetector(
            onHorizontalDragUpdate: (details) {
              // Calculate new scroll position based on the current position and delta
              final newOffset = customEditableTextController.scrollController.value.offset - details.delta.dx;

              // Jump to the new offset clamped within scrollable limits
              customEditableTextController.scrollController.value.jumpTo(
                newOffset.clamp(
                  customEditableTextController.scrollController.value.position.minScrollExtent,
                  customEditableTextController.scrollController.value.position.maxScrollExtent,
                ),
              );
              // customEditableTextController.setCursorPosition(CustomEditableTextFunctions.getCursorPosition(
              //   tapOffset: details.localPosition,
              //   scrollOffset: customEditableTextController.scrollController.value.offset,
              //   textWidths: customEditableTextController.textWidths,
              //   containerHeight: height,
              //   containerWidth: width,
              // ));

              // customEditableTextController.setCursorOffset(CustomEditableTextFunctions.getCursorOffset(
              //         textWidths: customEditableTextController.textWidths,
              //         scrollOffset: customEditableTextController.scrollController.value.offset,
              //         containerWidth: width,
              //         tapOffset: customEditableTextController.cursorPosition.value));

              // // Auto-scroll ListView if near edges
              // CustomEditableTextFunctions.handlePointerMovement(
              //     details.localPosition, customEditableTextController.scrollController.value, width, customEditableTextController.textWidths);
              // log("HorizontalDrag:\n    cursorOffset: ${customEditableTextController.cursorOffset.value}, cursorPosition: ${customEditableTextController.cursorPosition.value}");
            },
            onTapDown: (details) {
              log("TapDown => cursorOffset: ${customEditableTextController.cursorOffset.value}");
            },
            child: Stack(
              children: [
                ListView.builder(
                    padding: EdgeInsets.only(left: 400),
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    controller: customEditableTextController.scrollController.value,
                    itemBuilder: (context, index) {
                      return CustomEditableTextFunctions.makeCursorWidget(height);
                    }),
                ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: customEditableTextController.allElements.length,
                    controller: customEditableTextController.scrollController.value,
                    itemBuilder: (context, index) {
                      final element = customEditableTextController.allElements[index];
                      if (customEditableTextController.allElements.isEmpty) {
                        return const SizedBox(
                          child: Text(
                            "Empty rn",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        );
                      }
                      if (element.extraTexts == null) {
                        return CustomEditableTextFunctions.makeNormalTextWidget(customText: element);
                      }
                      return const SizedBox(
                        child: Text(
                          "Default Text",
                          style: TextStyle(color: Colors.yellow, fontSize: 16),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
