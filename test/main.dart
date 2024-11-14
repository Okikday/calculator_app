import 'dart:developer';

import 'package:calculator_app/common/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import 'editable_text_widget.dart';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    final EditableTextWidget editableTextWidget = EditableTextWidget();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black12,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: editableTextWidget.containerWidget()),
            const SizedBox(height: 24),
            CustomElevatedButton(onClick: () => editableTextWidget.addNormalInput("A"), label: "Input A", textSize: 16, backgroundColor: Colors.lightBlue,),
            const SizedBox(height: 16),
            CustomElevatedButton(onClick: () => editableTextWidget.addNormalInput("B"), label: "Input B", textSize: 16,),
            const SizedBox(height: 16),
            CustomElevatedButton(onClick: () => editableTextWidget.clearAll(), label: "Clear textbox", textSize: 16, backgroundColor: Colors.yellow, textColor: Colors.black,)
          ],
        ),
      ),
    );
  }
}