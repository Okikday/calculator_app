import 'package:calculator_app/common/colors.dart';
import 'package:flutter/material.dart';

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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
      height: height,
      width: width,
      decoration: BoxDecoration(color: CalculatorColors.mediumGray.withAlpha(200), borderRadius: BorderRadius.circular(24)),
    );
  }
}
