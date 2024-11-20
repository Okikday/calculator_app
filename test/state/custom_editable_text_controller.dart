import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/custom_text_element_model.dart';
import 'custom_editable_text_functions.dart';

final CustomEditableTextController customEditableTextController = Get.put<CustomEditableTextController>(CustomEditableTextController());

class CustomEditableTextController extends GetxController {
  Rx<TextStyle> customTextStyle = const TextStyle(fontSize: 50 * 0.8, color: Colors.white).obs;
  final Rx<ScrollController> scrollController = ScrollController().obs;

  RxList<CustomTextElementModel> allElements = <CustomTextElementModel>[].obs;
  RxList<double> textWidths = <double>[].obs;
  Rx<Offset> cursorPosition = const Offset(0, 0).obs;
  RxInt cursorOffset = 0.obs;

  Rx<Size> containerSize = const Size(200, 50).obs;

  setContainerSize(Size size) {
    containerSize.value = size;
    customTextStyle.value = customTextStyle.value.copyWith(fontSize: size.height * 0.8);
  }

  setGeneralTextStyle(TextStyle textStyle) => customTextStyle.value = textStyle;
  setCursorPosition(Offset position) => cursorPosition.value = position;
  setCursorOffset(int offset) => cursorOffset.value = offset;

  updateTextWidths() {
    textWidths.value = List.generate(allElements.length, (i) => i.toDouble());
    for (int index = 0; index < allElements.length; index++) {
      // Prone to modifications
      textWidths[index] = CustomEditableTextFunctions.measureTextSize(allElements[index].text, allElements[index].textStyle).width;
    }
  }

  void updateCursorScrollPos() {

    final double totalWidth = textWidths.fold(0.0, (sum, width) => sum + width);
    final bool isCursorPosLast = cursorPosition.value.dx + textWidths[cursorOffset.value] > containerSize.value.width;
    final double cursorPosLast = textWidths.fold(0.0, (sum, width) => sum + width > containerSize.value.width ? containerSize.value.width - 2 : sum + width);
    final double cursorPosNotLast = cursorPosition.value.dx + textWidths[cursorOffset.value] > containerSize.value.width ? containerSize.value.width - 20 : cursorPosition.value.dx + textWidths[cursorOffset.value];

    setCursorPosition(Offset(cursorOffset.value == textWidths.length ? cursorPosLast : cursorPosNotLast, 0));
    cursorOffset++;
    
    if (totalWidth > 380) {
      scrollController.value.animateTo(totalWidth - containerSize.value.width + 15, duration: const Duration(milliseconds: 150), curve: Curves.decelerate);
    }
    log("cursorOffset: ${cursorOffset.value}, cursorPosition: ${cursorPosition.value}");
    log("totalWidth: $totalWidth, maxScrollExtent: ${scrollController.value.position.maxScrollExtent}, scrollOffset: ${scrollController.value.offset}");
    
  }

  // Add a text or special text to the list
  void updateTextElement({
    required CustomTextElementModel customText,
    required int index,
  }) {
    if (customText.text.isNotEmpty) {
      if (index == allElements.length) {
        allElements.add(customText);
      } else {
        if (index >= 0 && index < allElements.length) {
          allElements.insert(index, customText);
        }
      }
    }
    updateTextWidths();
    updateCursorScrollPos();

    // log(allElements.map((e) => e.toJson()).toString());
    log(textWidths.toString());
  }

  void clearAllElements() {
    allElements.clear();
    textWidths.clear();
    setCursorPosition(Offset(textWidths.fold(0.0, (sum, width) => sum + width), 0));
    setCursorOffset(0);

    log(allElements.toString());
  }
}

// For allElements: if String, String text else Map => String text, List extraTexts, List extraTextsPlacements
/*
{
'text': "root", //Basically in unicode
'extraTexts': <String>['x', 'y'], //Mostly should be the ballot blank box in unicode
'extraTextsPlacements: <Alignment>[Alignment.topLeft]
}

*/

// For elementProperties: cumulativeWidth

