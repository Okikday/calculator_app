import 'dart:developer';

import 'package:flutter/material.dart';

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

class EditableTextWidget {
  // Controllers and Focus Nodes for back and front text fields
  static final TextEditingController backController = TextEditingController();
  static final FocusNode backFocusNode = FocusNode();
  static final TextEditingController frontController = TextEditingController();
  static final FocusNode frontFocusNode = FocusNode();
  static final ScrollController scrollController = ScrollController();

  // Maps and Lists to manage field elements and positioning
  final Map<String, dynamic> frontTextFieldElements = {};
  final List<Map<String, dynamic>> generalPositioning = [];

  // Dimensions
  final double height;
  final double width;

  EditableTextWidget({
    this.height = 100,
    this.width = 400,
  });

  // Initialize controllers for managing field elements and positioning
  void createControllers() {}

  // Adds a special input with positioning and custom configuration
  void addSpecialInput({
    required String name,
    required List<TextFieldPlacement> placements,
  }) {}

  void addNormalInput(
    String content,
  ) {
    final TextEditingController controller = backController;
    int cursorOffset = controller.selection.baseOffset;
    if (cursorOffset == -1) cursorOffset = controller.text.length;

    controller.text = controller.text.replaceRange(
      cursorOffset,
      cursorOffset,
      content,
    );

    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: cursorOffset + content.length),
    );
    log("Offset: ${HelperFunctions.measureTextWidth(content, TextStyle(fontSize: height * 0.8, color: Colors.white))}");
  }

  // Deletes content based on cursor position and element positioning
  void delCharacter() {}

  // Clears all inputs and resets controllers
  void clearAll() {
    backController.clear();
  }

  // Tracks and retrieves the text or element at a specified position
  Map<String, dynamic> getTextAtPosition(int position) {
    return {};
  }

  // Back text field (EditableText widget)
  Widget backTextField() {
    return Listener(
        onPointerDown: (event) {
          // log("Base offset: ${backController.selection.baseOffset} \nExtent offset: ${backController.selection.extentOffset}");
        },
        child: SizedBox(
          width: width,
          height: height,
          child: EditableText(
            scrollController: scrollController,
            controller: backController,
            focusNode: backFocusNode,
            style: TextStyle(fontSize: height * 0.8, color: Colors.white),
            cursorColor: Colors.blue.withOpacity(0.5),
            cursorOpacityAnimates: true,
            backgroundCursorColor: Colors.white,
            keyboardType: TextInputType.none,
          ),
        ));
  }

  // Front text field with positioning functionality
  Widget frontTextField({List<TextFieldPlacement>? placements}) {
    if (placements == null || placements.isEmpty) {
      return SizedBox(
        height: height,
        child: EditableText(
          controller: frontController,
          focusNode: frontFocusNode,
          style: TextStyle(fontSize: height * 0.8, color: Colors.black),
          cursorColor: Colors.red.withOpacity(0.5),
          backgroundCursorColor: Colors.white,
        ),
      );
    }
    return Container(); // Replace with further positioning logic
  }

  // Container to display layered text fields in a stack
  Widget containerWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue.withOpacity(0.1),
      ),
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          backTextField(),
        ],
      ),
    );
  }
}

class TextModel{
  final String text;
  final Map<TextFieldPlacement, String>? placementsAndTexts;

  const TextModel({
    required this.text,
    this.placementsAndTexts,

  });

  factory TextModel.fromMap(Map<String, dynamic> json){
    return TextModel(text: json['text'], placementsAndTexts: json['placementsAndTexts']);
  }

}

class SampleData{
  List<Map<String, dynamic>> keys = [
    {
    'text': "A",
  },
  {
    'text': "B",
  },
  {
    'text': "C",
    'placementsAndTexts': {
      TextFieldPlacement.centerLeft: "1",
      TextFieldPlacement.centerRight: "2"
    }
  },
  {
    'text': "D",
    'placementsAndTexts': {
      TextFieldPlacement.centerLeft: "3",
      TextFieldPlacement.centerRight: "4"
    }
  },

  ];
}

class HelperFunctions {
  static double measureTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.size.width;
  }
}
