import 'dart:developer';

import 'package:flutter/material.dart';
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
              customEditableTextController.setCursorPosition(CustomEditableTextFunctions.getCursorPosition(
                tapOffset: details.localPosition,
                scrollOffset: customEditableTextController.scrollController.value.offset,
                textWidths: customEditableTextController.textWidths,
                containerHeight: 100,
                containerWidth: 400,
              ));

              // Auto-scroll ListView if near edges
              CustomEditableTextFunctions.handlePointerMovement(details.localPosition, customEditableTextController.scrollController.value, 400, customEditableTextController.textWidths);
            },
            onTapDown: (details) {
              log("Horizontal update");
              customEditableTextController.setCursorPosition(CustomEditableTextFunctions.getCursorPosition(
                tapOffset: details.localPosition,
                scrollOffset: customEditableTextController.scrollController.value.offset,
                textWidths: customEditableTextController.textWidths,
                containerHeight: 100,
                containerWidth: 400,
              ));
            },
            child: Stack(
              children: [
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

                //Cursor
                // height prone to change
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.decelerate,
                  left: customEditableTextController.cursorPosition.value.dx,
                  child: Container(
                    width: 2,
                    height: height * 0.95,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
