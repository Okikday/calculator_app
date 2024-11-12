// import 'dart:developer';

// import 'package:calculator_app/common/constant_widgets.dart';
// import 'package:calculator_app/widgets/calculator/calculator_widgets_data/calculator_widgets_data.dart';
// import 'package:calculator_app/widgets/calculator/functions/common_functions.dart';
// import 'package:calculator_app/widgets/calculator/states/display_panel_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
// import 'package:get/get.dart';

// class ButtonFunctions {
//   // On Click the numbers section
//   static void onNumberSectionClicked({
//     required int allIndex,
//   }) {
//     // Button "Ans"
//     if (allIndex == 9) {
//       // Handle Ans functionality if needed
//     } else {
//       CommonFunctions.insertKeyInTextField(CalculatorWidgetsData.numbersKeys[allIndex]['name'].toString());
//     }
//   }

//   // On Click the AC sections
//   static void onAcSectionClicked({
//     required int index,
//   }) {
//     final QuillController controller = displayPanelState.inputController.value;

//     // Insert text for specific buttons
//     if (index <= 1 && index >= 0) {
//       CommonFunctions.insertKeyInTextField(CalculatorWidgetsData.acSectionKeys[index]['name'].toString());
//     }

//     // Button "AC" - Clear all text
//     if (index == 2) {
//       controller.clear();
//     }

//     // Button "DEL" - Delete selected text or character before cursor
//     if (index == 3) {
//       final selection = controller.selection;

//       if (selection.start != selection.end) {
//         // Delete the selected text
//         controller.document.delete(selection.start, selection.end);
//         controller.updateSelection(
//           TextSelection.collapsed(offset: selection.start),
//           ChangeSource.local,
//         );
//       } else if (selection.start > 0) {
//         // Delete character before cursor
//         controller.document.delete(selection.start - 1, selection.start);
//         controller.updateSelection(
//           TextSelection.collapsed(offset: selection.start - 1),
//           ChangeSource.local,
//         );
//       }
//     }
//   }

//   // On Click Sign Section
//   static void onSignsSectionClicked({required int index}) {
//     final QuillController controller = displayPanelState.inputController.value;
//     if (!displayPanelState.inputFocusNode.value.hasFocus) {
//       displayPanelState.inputFocusNode.value.requestFocus();
//     }

//     int cursorOffset = controller.selection.baseOffset;
//     if (cursorOffset == -1) cursorOffset = controller.document.length - 1;

//     final String newText = CalculatorWidgetsData.signsKeys[index]['name'].toString();

//     if (controller.document.length > 0) {
//       controller.document.insert(cursorOffset, newText);
//       controller.updateSelection(
//         TextSelection.collapsed(offset: cursorOffset + newText.length),
//         ChangeSource.local,
//       );
//     } else {
//       if (index == 2 || index == 3) {
//         controller.document.insert(cursorOffset, newText);
//         controller.updateSelection(
//           TextSelection.collapsed(offset: cursorOffset + newText.length),
//           ChangeSource.local,
//         );
//       } else {
//         ConstantWidgets.showFlushBar(Get.context!, "First input a number", duration: 1000);
//       }
//     }
//   }

//   // On Click Advanced Section
//   static void onAdvancedSectionClicked(int index) {
//     final QuillController controller = displayPanelState.inputController.value;

//     if (index == 11) {
//       // Handle specific functionality if needed
//     } else {
//       int cursorOffset = controller.selection.baseOffset;
//       if (cursorOffset == -1) cursorOffset = controller.document.length - 1;

//       final String newText = CalculatorWidgetsData.advancedPanelKeys[index]['inputAs'].toString();

//       controller.document.insert(cursorOffset, newText);
//       controller.updateSelection(
//         TextSelection.collapsed(offset: cursorOffset + newText.length),
//         ChangeSource.local,
//       );
//     }
//   }

//   // Move cursor left
//   static void moveCursorLeft() {
//     final QuillController controller = displayPanelState.inputController.value;
//     final int currentPosition = controller.selection.baseOffset;
//     if (currentPosition > 0) {
//       controller.updateSelection(
//         TextSelection.collapsed(offset: currentPosition - 1),
//         ChangeSource.local,
//       );
//     }
//   }

//   // Move cursor right
//   static void moveCursorRight() {
//     final QuillController controller = displayPanelState.inputController.value;
//     final int currentPosition = controller.selection.baseOffset;
//     if (currentPosition < controller.document.length - 1) {
//       controller.updateSelection(
//         TextSelection.collapsed(offset: currentPosition + 1),
//         ChangeSource.local,
//       );
//     }
//   }
// }

