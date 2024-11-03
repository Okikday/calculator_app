import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/common/constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignsSection extends StatelessWidget {
  final double height;
  final double width;

  const SignsSection({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final double aspectRatio = Get.size.aspectRatio;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: width,
          height: height * 0.82,
          decoration: BoxDecoration(color: CalculatorColors.mediumGray, borderRadius: BorderRadius.circular(60)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 4; i++)
                Container(
                  alignment: Alignment.center,
                  width: aspectRatio >= 0.56 ? width * 0.65 : width * 0.75,
                  height: aspectRatio >= 0.56 ? width * 0.65 : width * 0.75,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: ConstantWidgets.text(context, i.toString(), color: Colors.black),
                )
            ],
          ),
        ),
        Container(
          width: width,
          height: height * 0.15,
          decoration: BoxDecoration(color: CalculatorColors.tealBlue, borderRadius: BorderRadius.circular(48)),
        ),
      ],
    );
  }
}
