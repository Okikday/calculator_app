import 'dart:developer';

import 'package:calculator_app/common/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_editable_text.dart';
import 'state/custom_editable_text_controller.dart';

void main(){
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
            CustomElevatedButton(onClick: () => customEditableTextController.updateElement(text: "A"), label: "Input A", textSize: 16, backgroundColor: Colors.lightBlue,),
            const SizedBox(height: 16),
            CustomElevatedButton(onClick: () => customEditableTextController.updateElement(text: "B"), label: "Input B", textSize: 16,),
            const SizedBox(height: 16),
            CustomElevatedButton(onClick: () => customEditableTextController.clearAllElements(), label: "Clear textbox", textSize: 16, backgroundColor: Colors.yellow, textColor: Colors.black,)
          ],
        ),
      ),
    );
  }
}