import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/common/constant_widgets.dart';
import 'package:flutter/material.dart';

class AcSection extends StatelessWidget {
  final double height;
  final double width;
  const AcSection({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: CalculatorColors.tealBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < 4; i++)
            Container(
              alignment: Alignment.center,
              width: width * 0.2,
              height: width * 0.2,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: ConstantWidgets.text(context, i.toString(), color: Colors.black),
            )
        ],
      ),
    );
  }
}
