import 'dart:developer';

import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/common/constant_widgets.dart';
import 'package:calculator_app/common/custom_elevated_button.dart';
import 'package:calculator_app/widgets/calculator/calculator_widgets_data/calculator_widgets_data.dart';
import 'package:calculator_app/widgets/calculator/functions/button_functions.dart';
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
                          ButtonFunctions.onNumberSectionClicked(
                            allIndex: (rowIndex * 3 + index),
                          );
                        },
                        child: ConstantWidgets.text(context, CalculatorWidgetsData.numbersKeys[(rowIndex * 3 + index)]['name'].toString(),
                            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500))),
              );
            })));
  }
}
