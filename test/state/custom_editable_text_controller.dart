import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/custom_text_element_model.dart';
import 'custom_editable_text_functions.dart';

final CustomEditableTextController customEditableTextController = Get.put<CustomEditableTextController>(CustomEditableTextController());

class CustomEditableTextController extends GetxController {
  Rx<TextStyle> customTextStyle = const TextStyle(fontSize: 50 * 0.8, color: Colors.white).obs;
  final Rx<ScrollController> scrollController = ScrollController().obs;
  RxList<dynamic> allElements = <dynamic>[].obs;
  RxList<double> textWidths = <double>[].obs;
  RxInt cursorOffset = 0.obs;

  Rx<Size> containerSize = const Size(200, 50).obs;

  setContainerSize(Size size, {Size? cursorSize}) {
    containerSize.value = size;
    customTextStyle.value = customTextStyle.value.copyWith(fontSize: size.height * 0.8);

    if(cursorSize == null){

    }
  }
  setGeneralTextStyle(TextStyle textStyle) => customTextStyle.value = textStyle;

  setCursorOffset(int offset) => allElements.insert(offset, CustomEditableTextFunctions.makeCursorWidget(containerSize.value.height));
  void updateTextWidths() => textWidths.value = allElements.map((element) {

    return CustomEditableTextFunctions.measureTextSize(element.text, element.textStyle).width;
  }).toList();

  Future<void> _handleInsertScrollUpdate() async {
    
  }

  Future<void> _handleDeleteScrollUpdate() async {
    
  }

  // Add a text or special text to the list
  void addTextElement({
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
    _handleInsertScrollUpdate();
  }

  // Delete a text element at specified index
  void deleteTextElement({required int index}) {
    // log("index: $index");
    // double prevCharWidth = 0;
    // if (allElements.isEmpty || index == 0) return;

    // if (index == allElements.length) {
    //   prevCharWidth = textWidths.last;
    //   allElements.removeLast();
    // }
    // if (index > 0 && index < allElements.length) {
    //   prevCharWidth = textWidths[index - 1];
    //   allElements.removeAt(index - 1);
    // }
    // updateTextWidths();
    // _handleDeleteScrollUpdate();
  }

  void clearAllElements() {
    allElements.clear();
    textWidths.clear();
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

class CustomEditableTextControllerFunctions {}
