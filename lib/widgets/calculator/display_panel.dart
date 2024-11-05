import 'dart:ui';

import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/common/constant_widgets.dart';
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
    final AdvancedPanelState advancedPanelState = Get.put(AdvancedPanelState());
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
            child: InputTextField(advancedPanelState: advancedPanelState),
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
                Expanded(child: ConstantWidgets.text(context, "256", align: TextAlign.end, fontSize: 32))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  final AdvancedPanelState advancedPanelState;
  const InputTextField({super.key, required this.advancedPanelState});

  @override
  Widget build(BuildContext context) {
    final DisplayPanelState displayPanelState = Get.put<DisplayPanelState>(DisplayPanelState());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: EditableText(
        textAlign: TextAlign.end,
        controller: displayPanelState.inputController.value,
        focusNode: displayPanelState.inputFocusNode.value,
        autocorrect: false,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
        onChanged: (value) {
          
        },
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
    );
  }
}
