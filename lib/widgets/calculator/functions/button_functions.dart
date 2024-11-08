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
    // //Button "0"
    // else if (allIndex == 10) {
    // }
    else {
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
    if (!displayPanelState.inputFocusNode.value.hasFocus) {
      displayPanelState.inputFocusNode.value.requestFocus();
    }

    if (index <= 1 && index >= 0) {
      int cursorOffset = controller.selection.baseOffset;
      if (cursorOffset == -1) cursorOffset = controller.text.length;

      final String newText = CalculatorWidgetsData.acSectionKeys[index]['name'].toString();

      controller.text = controller.text.replaceRange(
        cursorOffset,
        cursorOffset,
        newText,
      );

      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: cursorOffset + newText.length),
      );
    }

    // Button "AC"
    if (index == 2) controller.clear();

    // Button "DEL"
    if (index == 3) {
      final TextSelection selection = controller.selection;

      if (selection.start != selection.end) {
        // Delete the selected text
        controller.text = controller.text.replaceRange(selection.start, selection.end, '');
        controller.selection = TextSelection.collapsed(offset: selection.start);
      } else if (selection.start > 0) {
        // Delete the character before the cursor if no selection
        controller.text = controller.text.replaceRange(selection.start - 1, selection.start, '');
        controller.selection = TextSelection.collapsed(offset: selection.start - 1);
      }
    }
  }

  // On Click Sign Section
  static void onSignsSectionClicked({required int index, required DisplayPanelState displayPanelState}) {
    final TextEditingController controller = displayPanelState.inputController.value;
    if (!displayPanelState.inputFocusNode.value.hasFocus) displayPanelState.inputFocusNode.value.requestFocus();

    int cursorOffset = controller.selection.baseOffset;
    if (cursorOffset == -1) cursorOffset = controller.text.length;

    final String newText = CalculatorWidgetsData.signsKeys[index]['name'].toString();

    if (controller.text.isNotEmpty) {
      controller.text = controller.text.replaceRange(
        cursorOffset,
        cursorOffset,
        newText,
      );

      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: cursorOffset + newText.length),
      );
    } else {
      if (index == 2 || index == 3) {
        controller.text = controller.text.replaceRange(
          cursorOffset,
          cursorOffset,
          newText,
        );

        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: cursorOffset + newText.length),
        );
      } else {
        ConstantWidgets.showFlushBar(Get.context!, "First Input a number", duration: 1000);
      }
    }
  }

  static void moveCursorLeft() {
    final controller = displayPanelState.inputController.value;
    final int currentPosition = controller.value.selection.baseOffset;
    if (currentPosition > 0) {
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: currentPosition - 1),
      );
    }
  }

  static void moveCursorRight() {
    final controller = displayPanelState.inputController.value;
    final int currentPosition = controller.selection.baseOffset;
    if (currentPosition < controller.text.length) {
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: currentPosition + 1),
      );
    }
  }
}
