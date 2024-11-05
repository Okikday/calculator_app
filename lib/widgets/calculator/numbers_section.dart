import 'dart:developer';

import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/common/constant_widgets.dart';
import 'package:calculator_app/common/custom_elevated_button.dart';
import 'package:calculator_app/widgets/calculator/calculator_widgets_data/calculator_widgets_data.dart';
import 'package:calculator_app/widgets/calculator/states/display_panel_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumbersSection extends StatelessWidget {
  final double height;
  final double width;

  const NumbersSection({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final double aspectRatio = Get.size.aspectRatio;
    log("aspectRatio: $aspectRatio");
    final DisplayPanelState displayPanelState = Get.put<DisplayPanelState>(DisplayPanelState());
    return Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: CalculatorColors.mediumGray, borderRadius: BorderRadius.circular(36)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (rowIndex) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    3,
                    (index) => CustomElevatedButton(
                        pixelHeight: aspectRatio >= 0.56 ? width * 0.25 : width * 0.27,
                        pixelWidth: aspectRatio >= 0.56 ? width * 0.25 : width * 0.27,
                        shape: const CircleBorder(),
                        backgroundColor: CalculatorColors.lightGray,
                        onClick: () {
                          final selection = displayPanelState.inputController.value.selection;
                          final String newText = CalculatorWidgetsData.numbersKeys[(rowIndex * 3 + index)]['name'].toString();

                          // Check if there's a valid cursor position
                          if (selection.baseOffset >= 0) {
                            final newTextValue = '${selection.textBefore(displayPanelState.inputController.value.text)}'
                                '$newText'
                                '${selection.textAfter(displayPanelState.inputController.value.text)}';

                            // Update the controller's text and move the cursor to the end of the inserted text
                            displayPanelState.inputController.value.value = TextEditingValue(
                              text: newTextValue,
                              selection: TextSelection.collapsed(offset: displayPanelState.inputController.value.selection.baseOffset.truncate() + newText.length),
                            );
                          }
                        },
                        child: ConstantWidgets.text(context, CalculatorWidgetsData.numbersKeys[(rowIndex * 3 + index)]['name'].toString(),
                            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500))),
              );
            })));
  }
}
