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
  Rx<Offset> cursorPosition = const Offset(0, 0).obs;

  @override
  void onInit() {
    super.onInit();
    setCursorOffset();
  }

// FUNCTION:
  initContainerProperties(Size size, {CursorModel? cursor, TextStyle? textStyle}) {
    containerSize.value = size;
    cursor == null ? fieldCursor.value = CursorModel(height: size.height) : fieldCursor.value = cursor;
    textStyle == null ? customTextStyle.value = customTextStyle.value.copyWith(fontSize: size.height * 0.8) : customTextStyle.value = textStyle;
    _updateTextStyles();
  }

// FUNCTION:
  _updateTextStyles() {
    allElements.value = allElements.map((element) {
      if (element is CustomTextElementModel) return element.copyWith(textStyle: customTextStyle.value);
      return element;
    }).toList();
    updateElementsWidth();
  }

// FUNCTION:
  setCursorOffset({int? offset}) {
    if (offset != null && offset < 0) return;
    if (offset == allElements.length && offset != 0 && offset != null) {
      setCursorOffset(offset: offset - 1);
      return;
    }
    allElements.removeWhere((item) => item is CursorModel);
    offset == null || offset == allElements.length ? allElements.add(fieldCursor.value) : allElements.insert(offset, fieldCursor.value);
    cursorOffset.value = allElements.indexWhere((item) => item is CursorModel);
  }

// FUNCTION:
  // Update all the element in the allElements width
  void updateElementsWidth() {
    if (allElements.isEmpty) return;
    textWidths.value = allElements.map((element) {
      return element is CustomTextElementModel
          ? CustomEditableTextFunctions.measureTextSize(element.text, element.textStyle).width
          : (element is CursorModel ? element.width : 0.0);
    }).toList();
  }

// FUNCTION:
  _handleAddScrollUpdate() {
    final double totalWidth = textWidths.fold(0.0, (sum, width) => sum + width);
    final double containerWidth = containerSize.value.width;
    final double scrollOffset = scrollController.value.offset;
    final double cursorPos = textWidths.take(cursorOffset.value + 1).fold(0.0, (sum, width) => sum + width);

    if (cursorPos > scrollOffset + containerWidth) {
      // Calculate the max scrollable offset to avoid overscroll
      final double maxScrollOffset = totalWidth - containerWidth;
      final double newScrollOffset = (cursorPos - containerWidth).clamp(0.0, maxScrollOffset);
      scrollController.value.animateTo(newScrollOffset, duration: const Duration(milliseconds: 75), curve: Curves.decelerate);
    }
  }

void _handleDeleteScrollUpdate() {
  if (textWidths.isEmpty || containerSize.value.width <= 0) return;

  final double totalWidth = textWidths.fold(0.0, (sum, width) => sum + width);
  final double containerWidth = containerSize.value.width;
  final double scrollOffset = scrollController.value.offset;

  if (totalWidth <= containerWidth) {
    if (scrollOffset != 0) {
      scrollController.value.animateTo(
        0.0,
        duration: const Duration(milliseconds: 75),
        curve: Curves.decelerate
      );
    }
    return;
  }

  double cursorPos = textWidths.take(cursorOffset.value).fold(0.0, (sum, width) => sum + width);
  
  // Ensure at least two characters are visible to the left of the cursor
  double charactersToLeftWidth = 0.0;
  int charsToShow = 0;
  
  while (charsToShow < cursorOffset.value && charactersToLeftWidth < containerWidth / 2) {
    charactersToLeftWidth += textWidths[cursorOffset.value - charsToShow - 1];
    charsToShow++;
  }

  if (cursorPos < scrollOffset) {
    double newScrollOffset = (cursorPos - charactersToLeftWidth)
        .clamp(0.0, totalWidth - containerWidth);

    scrollController.value.animateTo(
      newScrollOffset,
      duration: const Duration(milliseconds: 75),
      curve: Curves.decelerate
    );
  }
}

// FUNCTION:
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
      setCursorOffset(offset: index + 1);
      log("index >= 0 && index < allElements.length case: ${cursorOffset.value}");
    }

    updateElementsWidth();
    _handleAddScrollUpdate();
  }

// FUNCTION:
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
    _handleDeleteScrollUpdate();
  }

// FUNCTION:
  void clearAllElements() {
    allElements.clear();
    textWidths.clear();
    setCursorOffset(offset: 0);
    log(allElements.map((item) => item is CustomTextElementModel ? item.text : "CursorPosition").toList().toString());
  }

// FUNCTION:
  void moveLeft() {
    // Early return if cursor is already at the start
    if (cursorOffset.value <= 0) {
      return;
    }

    // Ensure textWidths list is not empty and has enough elements
    if (textWidths.isEmpty || cursorOffset.value > textWidths.length) {
      // Reset to a safe state if data is inconsistent
      setCursorOffset(offset: 0);
      return;
    }

    // Calculate cumulative width of characters before the current cursor position
    double cumulativeWidth = 0.0;
    for (int i = 0; i < cursorOffset.value; i++) {
      cumulativeWidth += textWidths[i];
    }

    final scrollOffset = scrollController.value.offset;
    final scrollPosition = scrollController.value.position;

    // Determine the width of the first visible character
    double firstVisibleCharWidth = textWidths[0];
    // double firstVisibleCharCumulativeWidth = firstVisibleCharWidth;

    // Check if moving left requires scrolling
    if (cumulativeWidth < scrollOffset + firstVisibleCharWidth) {
      // Calculate new scroll offset
      double newOffset = (scrollOffset - textWidths[cursorOffset.value - 1]).clamp(0.0, scrollPosition.maxScrollExtent);

      scrollController.value.jumpTo(newOffset);
    }

    // Always move the cursor left
    setCursorOffset(offset: cursorOffset.value - 1);
  }

// FUNCTION:
  void moveRight() {
  if (cursorOffset.value >= textWidths.length) return;

  if (textWidths.isEmpty || cursorOffset.value < 0) {
    setCursorOffset(offset: 0);
    return;
  }

  double cumulativeWidth = 0.0;
  for (int i = 0; i < cursorOffset.value; i++) {
    cumulativeWidth += textWidths[i];
  }

  final scrollOffset = scrollController.value.offset;
  final containerWidth = containerSize.value.width;
  final totalWidth = textWidths.fold(0.0, (sum, width) => sum + width);
  final currentCharWidth = textWidths[cursorOffset.value];
  final nextCumulativeWidth = cumulativeWidth + currentCharWidth;

  if (nextCumulativeWidth + fieldCursor.value.width > scrollOffset + containerWidth) {
    double newOffset = (nextCumulativeWidth + fieldCursor.value.width - containerWidth)
        .clamp(0.0, totalWidth - containerWidth);

    scrollController.value.jumpTo(newOffset);
  } else if (nextCumulativeWidth + fieldCursor.value.width >= totalWidth) {
    // Ensure that we don't lose visibility of the cursor at the end
    scrollController.value.jumpTo(scrollController.value.position.maxScrollExtent);
  }

  setCursorOffset(offset: cursorOffset.value + 1);
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
