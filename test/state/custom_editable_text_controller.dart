import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/custom_text_element_model.dart';
import 'custom_editable_text_functions.dart';

final CustomEditableTextController customEditableTextController = Get.put<CustomEditableTextController>(CustomEditableTextController());

class CustomEditableTextController extends GetxController {
  Rx<TextStyle> customTextStyle = const TextStyle(fontSize: 100 * 0.8, color: Colors.white).obs;
  final Rx<ScrollController> scrollController = ScrollController().obs;

  RxList<CustomTextElementModel> allElements = <CustomTextElementModel>[].obs;
  RxList<double> textWidths = <double>[].obs;
  Rx<Offset> cursorPosition = const Offset(0, 0).obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to scroll changes
    // scrollController.value.addListener(() {
    //   // final newCursorPosition = CustomEditableTextFunctions.getCursorPosition(
    //   //   tapOffset: Offset.zero, // Base offset for recalculating with the scroll
    //   //   scrollOffset: scrollController.value.offset,
    //   //   textWidths: customEditableTextController.textWidths,
    //   //   containerHeight: 100,
    //   //   containerWidth: 400,
    //   // );

    //   // // Update the cursor position as you scroll
    //   // customEditableTextController.setCursorPosition(newCursorPosition);
    // });
  }


  setGeneralTextStyle(TextStyle textStyle) => customTextStyle.value = textStyle;
  setCursorPosition(Offset position) => cursorPosition.value = position;

  updateTextWidths() {
    textWidths.value = List.generate(allElements.length, (i) => i.toDouble());
    for (int index = 0; index < allElements.length; index++) {
      // Prone to modifications
      textWidths[index] = CustomEditableTextFunctions.measureTextSize(allElements[index].text, allElements[index].textStyle).width;
    }
  }

  void updateScrollPosition() {
    final double totalWidth = textWidths.fold(0.0, (sum, width) => sum + width);
    log("totalWidth: $totalWidth");
    if (totalWidth > 400) {
      scrollController.value.jumpTo(totalWidth - 400 + textWidths[textWidths.length - 1]);
    }
    setCursorPosition(Offset(textWidths.fold(0.0, (sum, width) => sum + width > 400 ? 380 : sum + width), 0));
  }

  // Add a text or special text to the list
  void updateTextElement({
    required CustomTextElementModel customText,
    int? index,
  }) {
    if (customText.text.isNotEmpty) {
      if (index == null || index == allElements.length) {
        allElements.add(customText);
      } else {
        if (index >= 0 && index < allElements.length) {
          allElements.insert(index, customText);
        }
      }
    }
    updateTextWidths();
    updateScrollPosition();
    
    
    // log(allElements.map((e) => e.toJson()).toString());
    log(textWidths.toString());
  }

  void clearAllElements() {
    allElements.clear();
    textWidths.clear();
    setCursorPosition(Offset(textWidths.fold(0.0, (sum, width) => sum + width), 0));
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


