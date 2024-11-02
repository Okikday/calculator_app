import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/common/constant_widgets.dart';
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
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      padding: const EdgeInsets.all(12),
      height: height,
      width: width,
      decoration: BoxDecoration(color: CalculatorColors.mediumGray.withAlpha(200), borderRadius: BorderRadius.circular(24)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: height * 0.35, width: width, child: ConstantWidgets.text(context, "128 + 128", fontSize: 32, align: TextAlign.end),),
          Container(height: 8, width: width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: CalculatorColors.lightGray),),
          Row(
            children: [
            ConstantWidgets.text(context, "=", fontSize: 32),
            Expanded(child: ConstantWidgets.text(context, "256", align: TextAlign.end, fontSize: 32))
          ],)
        ],
      ),
    );
  }
}
