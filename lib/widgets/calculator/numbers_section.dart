import 'dart:developer';

import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/common/constant_widgets.dart';
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

    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: CalculatorColors.mediumGray, borderRadius: BorderRadius.circular(36)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for(int rowIndex = 0; rowIndex < 4; rowIndex++)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for(int i = 0; i < 3; i++)
              Container(
            width: aspectRatio >= 0.56 ? width * 0.25 : width * 0.27,
            height: aspectRatio >= 0.56 ? width * 0.25 : width * 0.27,
              alignment: Alignment.center,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: ConstantWidgets.text(context, (i + 1).toString(), color: Colors.black))
            ],
          )
        ],
      )
    );
  }
}
