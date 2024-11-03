import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/common/constant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      margin: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.04),
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      height: height,
      width: width,
      decoration: BoxDecoration(color: CalculatorColors.mediumGray.withAlpha(200), borderRadius: BorderRadius.circular(24)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(
          height: height - height * 0.04,
          width: width * 0.6 - width * 0.04,
          child: Center(child: AdvancedFuncsGridView(width: width * 0.66 - width * 0.04, height: height - height * 0.04)),
        ),
        const VerticalDivider(),
        SizedBox(
          height: height - height * 0.04,
          width: width * 0.3 - width * 0.04,
          child: NavigationFuncSection(height: height - height * 0.04, width: width * 0.3 - width * 0.04),
        ),
      ]),
    );
  }
}

class NavigationFuncSection extends StatelessWidget {
  const NavigationFuncSection({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              height: height * 0.2,
              width: width * 0.4,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              height: height * 0.2,
              width: width * 0.4,
            ),
          ],
        ),
        Container(
          width: width * 0.95,
          height: width * 0.95,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        )
      ],
    );
  }
}

class AdvancedFuncsGridView extends StatelessWidget {
  const AdvancedFuncsGridView({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final double aspectRatio = Get.size.aspectRatio;

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for(int rowIndex = 0; rowIndex < 3; rowIndex++)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for(int i = 0; i < 4; i++)
              Container(
              width: aspectRatio >= 0.56 ? width * 0.16 : width * 0.2,
              height: aspectRatio >= 0.56 ? width * 0.16 : width * 0.2,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: ConstantWidgets.text(context, i.toString(), color: Colors.black),
            )
            ],
          )
        ],
      );
  }
}
