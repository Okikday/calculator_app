import 'dart:developer';
import 'dart:ui';

import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/common/constant_widgets.dart';
import 'package:calculator_app/widgets/calculator/functions/calculations_functions.dart';
import 'package:calculator_app/widgets/calculator/states/advanced_panel_state.dart';
import 'package:calculator_app/widgets/calculator/states/display_panel_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayPanel extends StatelessWidget {
  final double height;
  final double width;

  const DisplayPanel({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final DisplayPanelState displayPanelState = Get.put<DisplayPanelState>(DisplayPanelState());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      padding: const EdgeInsets.all(12),
      height: height,
      width: width,
      decoration: BoxDecoration(color: CalculatorColors.mediumGray.withAlpha(200), borderRadius: BorderRadius.circular(24)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: height * 0.35,
            width: width,
            child: InputTextField(displayPanelState: displayPanelState),
          ),
          Container(
            height: 8,
            width: width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: CalculatorColors.lightGray),
          ),
          SizedBox(
            height: height * 0.35,
            child: Row(
              children: [
                ConstantWidgets.text(context, "=", fontSize: 32),
                Expanded(child: ConstantWidgets.text(context, CalculationsFunctions.evaluateExpression(displayPanelState.inputController.value.text), align: TextAlign.end, fontSize: 32))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  final DisplayPanelState displayPanelState;

  const InputTextField({super.key, required this.displayPanelState});

  @override
  Widget build(BuildContext context) {
    
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: EditableText(
          textAlign: TextAlign.right,
          controller: displayPanelState.inputController.value,
          focusNode: displayPanelState.inputFocusNode.value,
          scrollController: displayPanelState.inputScrollController.value,
          autocorrect: false,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 32,
          ),
          cursorColor: Colors.blue,
          backgroundCursorColor: Colors.transparent,
          maxLines: 1,
          keyboardType: TextInputType.none,
          cursorOpacityAnimates: true,
          cursorRadius: const Radius.circular(4),
          selectionColor: Colors.blue,
          selectionHeightStyle: BoxHeightStyle.max,
          enableInteractiveSelection: true,
        ),
      ),
    );
  }
}
