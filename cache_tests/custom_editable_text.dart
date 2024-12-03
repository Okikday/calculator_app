import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'models/custom_editable_text_models.dart';
import 'state/custom_editable_text_controller.dart';
import 'state/custom_editable_text_functions.dart';

class CustomEditableText extends StatelessWidget {
  final double height;
  final double width;
  final TextStyle textStyle;

  const CustomEditableText({
    super.key,
    this.height = 100,
    this.width = 350,
    this.textStyle = const TextStyle(
      fontSize: 100 * 0.8,
      color: Colors.white,
    ),
  });

  @override
  Widget build(BuildContext context) {
    
    customEditableTextController.initContainerProperties(Size(width, height),);
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
             
            },
            onTapDown: (details) {
              final int clickedCursorOffset = CustomEditableTextFunctions.getCursorOffset(cursorWidth: customEditableTextController.fieldCursor.value.width, containerWidth: width, tapOffset: details.localPosition, textWidths: customEditableTextController.textWidths, scrollOffset: customEditableTextController.scrollController.value.offset,);
              customEditableTextController.setCursorOffset(offset: clickedCursorOffset);
              log("cursorPosition: ${CustomEditableTextFunctions.getCursorPosition(containerHeight: height, containerWidth: width, tapOffset: details.localPosition, textWidths: customEditableTextController.textWidths, scrollOffset: customEditableTextController.scrollController.value.offset,)}");
              log("textWidths: ${customEditableTextController.textWidths}");
              log("clickedCursorOffset: $clickedCursorOffset");
              log("TapDown => current cursorOffset: ${customEditableTextController.cursorOffset.value}");
            },
            child: Stack(
              children: [
                ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: customEditableTextController.allElements.length,
                      controller: customEditableTextController.scrollController.value,
                      physics: const ClampingScrollPhysics(),
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
                        else if(element is CustomTextElementModel){
                          if (element.extraTexts == null) {
                          return CustomEditableTextFunctions.makeNormalTextWidget(customText: element);
                        }else{
                          return const SizedBox(child: Text("Not yet recognized!"),);
                        }
                        }else if(element is CursorModel){
                          return CustomEditableTextFunctions.makeCursorWidget(element);
                        }else{
                          return const SizedBox(
                          child: Text(
                            "Default Text",
                            style: TextStyle(color: Colors.yellow, fontSize: 16),
                          ),
                        );
                        }
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
