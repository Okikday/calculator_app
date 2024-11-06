import 'dart:developer';

import 'package:calculator_app/common/constant_widgets.dart';
import 'package:calculator_app/widgets/calculator/calculator_widgets_data/calculator_widgets_data.dart';
import 'package:calculator_app/widgets/calculator/states/display_panel_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonFunctions {
  // On Click the numbers section
  static void onNumberSectionClicked({
    required int allIndex,
    required DisplayPanelState displayPanelState,
  }) {
    final TextEditingController controller = displayPanelState.inputController.value;
    if (!displayPanelState.inputFocusNode.value.hasFocus) displayPanelState.inputFocusNode.value.requestFocus();

    //Button "Ans"
    if (allIndex == 9) {
    }
    //Button "0"
    else if (allIndex == 10) {
    } 
    //Button "." (Decimal)
    else if (allIndex == 11) {
    } else {
      int cursorOffset = controller.selection.baseOffset;
      if (cursorOffset == -1) cursorOffset = controller.text.length;

      final String newText = CalculatorWidgetsData.numbersKeys[allIndex]['name'].toString();

      controller.text = controller.text.replaceRange(
        cursorOffset,
        cursorOffset,
        newText,
      );

      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: cursorOffset + newText.length),
      );
    }
  }


  // On Click the AC sections
  static void onAcSectionClicked({
    required int index,
    required DisplayPanelState displayPanelState,
  }) {
    final TextEditingController controller = displayPanelState.inputController.value;
    if (!displayPanelState.inputFocusNode.value.hasFocus) displayPanelState.inputFocusNode.value.requestFocus();

    //Button "AC"
    if (index == 2) controller.clear();

    //Button "DEL"
    if (index == 3) {
      
      int cursorOffset = controller.selection.baseOffset;
      if (cursorOffset == -1) cursorOffset = controller.text.length;

      if (cursorOffset > 0) {
        controller.text = controller.text.replaceRange(cursorOffset - 1, cursorOffset, '');
        controller.selection = TextSelection.fromPosition(TextPosition(offset: cursorOffset - 1));
      }

    }
  }

  // On Click Sign Section
  static void onSignsSectionClicked({
    required int index,
    required DisplayPanelState displayPanelState
  }){
    final TextEditingController controller = displayPanelState.inputController.value;
    if (!displayPanelState.inputFocusNode.value.hasFocus) displayPanelState.inputFocusNode.value.requestFocus();

    log("text is empty?: ${controller.text.isEmpty}");
    if(controller.text.isNotEmpty){
      int cursorOffset = controller.selection.baseOffset;
      if (cursorOffset == -1) cursorOffset = controller.text.length;

      final String newText = CalculatorWidgetsData.signsKeys[index]['name'].toString();

      controller.text = controller.text.replaceRange(
        cursorOffset,
        cursorOffset,
        newText,
      );

      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: cursorOffset + newText.length),
      );
    }else{
      ConstantWidgets.showFlushBar(Get.context!, "First Input a number", duration: 1000);
    }
  }
}
