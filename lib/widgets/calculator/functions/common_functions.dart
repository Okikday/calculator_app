
import 'package:calculator_app/widgets/calculator/states/display_panel_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

// class CommonFunctions {
//   static void insertKeyInTextField(String newText) {
//     final TextEditingController controller = displayPanelState.inputController.value;
//     if (!displayPanelState.inputFocusNode.value.hasFocus) {
//       displayPanelState.inputFocusNode.value.requestFocus();
//     }

//     int cursorOffset = controller.selection.baseOffset;
//     if (cursorOffset == -1) {
//       // Place cursor at the end if no selection
//       cursorOffset = controller.selection.baseOffset - 1;
//     }

//     // Insert text at the cursor position
//     controller.document.insert(cursorOffset, newText);

//     // Update the selection to move the cursor after the inserted text
//     controller.updateSelection(
//       TextSelection.collapsed(offset: cursorOffset + newText.length),
//       ChangeSource.local,
//     );
//   }
// }
