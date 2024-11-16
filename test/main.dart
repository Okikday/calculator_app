import 'dart:developer';

import 'package:calculator_app/common/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_editable_text.dart';
import 'models/custom_text_element_model.dart';
import 'state/custom_editable_text_controller.dart';
import 'state/custom_editable_text_functions.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> globalNavKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: globalNavKey,
      home: Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: CustomEditableText()),
            const SizedBox(height: 24),
            CustomElevatedButton(
              onClick: () => customEditableTextController.updateTextElement(
                  customText: CustomTextElementModel(text: "A"),
                  index: CustomEditableTextFunctions.getCursorOffset(
                      textWidths: customEditableTextController.textWidths,
                      scrollOffset: customEditableTextController.scrollController.value.offset,
                      containerWidth: customEditableTextController.containerSize.value.width,
                      tapOffset: 
                      )),
              label: "Input A",
              textSize: 16,
              backgroundColor: Colors.lightBlue,
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              onClick: () => customEditableTextController.updateTextElement(customText: CustomTextElementModel(text: "B")),
              label: "Input B",
              textSize: 16,
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              onClick: () => customEditableTextController.clearAllElements(),
              label: "Clear textbox",
              textSize: 16,
              backgroundColor: Colors.yellow,
              textColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
