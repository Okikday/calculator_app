import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TextFieldPlacement {
  rightSubscript,
  rightSuperscript,
  leftSubscript,
  leftSuperScript,
  bottomSubscript,
  topSuperscript,
  centerLeft,
  centerRight,
}

final CustomEditableTextController customEditableTextController = Get.put<CustomEditableTextController>(CustomEditableTextController());

class CustomEditableTextController extends GetxController {
  RxList<dynamic> allElements = [].obs;
  RxList<Map<String, dynamic>> elementProperties = <Map<String, dynamic>>[].obs;
  final Rx<ScrollController> scrollController = ScrollController().obs;

  // Add a text or special text to the list
  void updateElement({
    String text = '',
    Map<String, dynamic>? specialText,
    int? index,
  }) {
    // Special Text is priortized if it's not null and not empty
    if (specialText != null && specialText.isNotEmpty) {
      // Add a special text and special text widget to the List
      if (index == null || index == allElements.length) {
        allElements.add(specialText);
      } else {
        if (index < allElements.length && index >= 0) {
          allElements.insert(index, specialText);
        }
      }
    } else if (text.isNotEmpty) {
      // Add a text and text widget to the List
      if (index == null || index == allElements.length) {
        allElements.add(text);
      } else {
        if (index < allElements.length && index >= 0) {
          allElements.insert(index, text);
        }
      }
    }
    log(allElements.toString());
  }

  getCursorPosition(){

  }

  void clearAllElements() {
    allElements.clear();
    log(allElements.toString());
  }
}
