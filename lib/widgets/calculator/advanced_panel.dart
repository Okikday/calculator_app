import 'package:calculator_app/common/colors.dart';
import 'package:flutter/material.dart';

class AdvancedPanel extends StatelessWidget {
  final double height;
  final double width;

  const AdvancedPanel({
    super.key,
    required this.height,
    required this.width,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      height: height,
      width: width,
      decoration: BoxDecoration(color: CalculatorColors.mediumGray.withAlpha(200), borderRadius: BorderRadius.circular(24)),
    );
  }
}
