import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/custom_editable_text_models.dart';
import 'custom_editable_text_functions.dart';

final CustomEditableTextController customEditableTextController = Get.put<CustomEditableTextController>(CustomEditableTextController());

class CustomEditableTextController extends GetxController {
  // Container properties
  Rx<TextStyle> customTextStyle = const TextStyle(fontSize: 50 * 0.8, color: Colors.white).obs;
  Rx<Size> containerSize = const Size(200, 50).obs;
  Rx<CursorModel> fieldCursor = CursorModel(height: 50).obs;

  final Rx<ScrollController> scrollController = ScrollController().obs;

  RxList<dynamic> allElements = <dynamic>[].obs;
  RxList<double> textWidths = <double>[].obs;
  RxInt cursorOffset = 0.obs;
  
  @override
  void onInit(){
    super.onInit();
    setCursorOffset();
  }
  initContainerProperties(Size size, {CursorModel? cursor, TextStyle? textStyle}) {
    containerSize.value = size;
    cursor == null ? fieldCursor.value = CursorModel(height: size.height) : fieldCursor.value = cursor;
    textStyle == null ? customTextStyle.value = customTextStyle.value.copyWith(fontSize: size.height * 0.8) : customTextStyle.value = textStyle;
  }

  setCursorOffset({int? offset}) {
    if(offset == allElements.length && offset != 0 && offset != null){
      setCursorOffset(offset: offset-1);
      return;
    }
    allElements.removeWhere((item) => item is CursorModel);
    offset == null || offset == allElements.length ? allElements.add(fieldCursor.value) : allElements.insert(offset, fieldCursor.value);
    cursorOffset.value = allElements.indexWhere((item) => item is CursorModel);
  }

  // Update all the element in the allElements width
  void updateElementsWidth() {
    if (allElements.isEmpty) return;
    textWidths.value = allElements.map((element) {
      return element is CustomTextElementModel
          ? CustomEditableTextFunctions.measureTextSize(element.text, element.textStyle).width
          : (element is CursorModel ? element.width : 0.0);
    }).toList();
  }

  _handleAddScrollUpdate(){

  }

  _handleDeleteScrollUpdate(){

  }

  

  // Add a text or special text to the list
  void addTextElement({
    required CustomTextElementModel customText,
    required int index,
  }) {
    if (customText.text.isNotEmpty && index == allElements.length) {
      allElements.add(customText);
      setCursorOffset();
      log("index == allElements.length case: ${cursorOffset.value}");
    }
    if (customText.text.isNotEmpty && (index >= 0 && index < allElements.length)) {
      allElements.insert(index, customText);
      setCursorOffset();
      log("index >= 0 && index < allElements.length case: ${cursorOffset.value}");
    }
    updateElementsWidth();
  }

  // Delete a text element at specified index
  void deleteTextElement({required int index}) {
    log("index: $index");
    if (allElements.isEmpty || index == 0) return;

    if (index == allElements.length) {
      allElements.removeAt(index - 2);
      setCursorOffset();
    }
    if (index > 0 && index < allElements.length) {
      allElements.removeAt(index - 1);
      setCursorOffset(offset: index - 1);
    }
    updateElementsWidth();
    // _handleDeleteScrollUpdate();
  }

  void clearAllElements() {
    allElements.clear();
    textWidths.clear();
    setCursorOffset(offset: 0);
    log(allElements.map((item) => item is CustomTextElementModel ? item.text : "CursorPosition").toList().toString());
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
