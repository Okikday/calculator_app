import 'dart:developer';

import 'package:calculator_app/common/constant_widgets.dart';
import 'package:calculator_app/common/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_editable_text.dart';
import 'models/custom_editable_text_models.dart';
import 'state/custom_editable_text_controller.dart';

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
            Center(child: CustomEditableText(width: 350,)),
            const SizedBox(height: 24),
            CustomElevatedButton(
              onClick: () => customEditableTextController.addTextElement(
                  customText: CustomTextElementModel(text: "A", textStyle: customEditableTextController.customTextStyle.value), index: customEditableTextController.cursorOffset.value),
              label: "Input A",
              textSize: 16,
              backgroundColor: Colors.lightBlue,
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              onClick: () => customEditableTextController.addTextElement(
                  customText: CustomTextElementModel(text: "B", textStyle: customEditableTextController.customTextStyle.value), index: customEditableTextController.cursorOffset.value),
              label: "Input B",
              textSize: 16,
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              onClick: () => customEditableTextController.deleteTextElement(index: customEditableTextController.cursorOffset.value ),
              label: "Backspace",
              textSize: 16,
              backgroundColor: Colors.red,
              textColor: Colors.black,
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              onClick: () => customEditableTextController.clearAllElements(),
              label: "Clear textbox",
              textSize: 16,
              backgroundColor: Colors.yellow,
              textColor: Colors.black,
            ),
            const SizedBox(height: 24,),
            CustomElevatedButton(
              onClick: (){
                customEditableTextController.moveLeft();
              },
              label: "Move left",
              textSize: 16,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.white,
            ),
            const SizedBox(height: 24,),
            CustomElevatedButton(
              onClick: (){
                customEditableTextController.moveRight();
              },
              label: "Move right",
              textSize: 16,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.white,
            ),
            const SizedBox(height: 24,),
            CustomElevatedButton(
              onClick: (){ConstantWidgets.showFlushBar(Get.context!, "Nothing to do");},
              label: "Random action",
              textSize: 16,
              backgroundColor: Colors.white,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
