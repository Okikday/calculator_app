import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/common/constant_widgets.dart';
import 'package:calculator_app/common/custom_elevated_button.dart';
import 'package:calculator_app/widgets/calculator/calculator_widgets_data/calculator_widgets_data.dart';
import 'package:calculator_app/widgets/calculator/functions/button_functions.dart';
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
          child: Center(child: AdvancedKeysGridView(width: width * 0.66 - width * 0.04, height: height - height * 0.04)),
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
            CustomElevatedButton(
              backgroundColor: CalculatorColors.mintGreen,
              pixelHeight: height * 0.14,
              pixelWidth: width * 0.44,
              borderRadius: 4,
              onClick: (){},
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ConstantWidgets.text(context, "SHIFT", fontWeight: FontWeight.w600),
                ),
              ),
            ),
            CustomElevatedButton(
              backgroundColor: CalculatorColors.lavender,
              pixelHeight: height * 0.14,
              pixelWidth: width * 0.42,
              borderRadius: 4,
              onClick: (){},
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ConstantWidgets.text(context, "MODE", fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
        Container(
            width: width * 0.95,
            height: width * 0.95,
            padding: EdgeInsets.all(width * 0.95 * 0.03),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){},
                  child: Image.asset(
                    "assets/icons/top_nav_icon.png",
                    width: width * 0.95 * 0.28,
                    height: width * 0.95 * 0.28,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  GestureDetector(
                  onTap: ButtonFunctions.moveCursorLeft,
                  child: Image.asset(
                    "assets/icons/left_nav_icon.png",
                    width: width * 0.95 * 0.28,
                    height: width * 0.95 * 0.28,
                  ),
                ),
                GestureDetector(
                  onTap: ButtonFunctions.moveCursorRight,
                  
                  child: Image.asset(
                    "assets/icons/right_nav_icon.png",
                    width: width * 0.95 * 0.28,
                    height: width * 0.95 * 0.28,
                  ),
                ),
                ]),
                GestureDetector(
                  onTap: (){},
                  child: Image.asset(
                    "assets/icons/bottom_nav_icon.png",
                    width: width * 0.95 * 0.28,
                    height: width * 0.95 * 0.28,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}

class AdvancedKeysGridView extends StatelessWidget {
  const AdvancedKeysGridView({
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
        for (int rowIndex = 0; rowIndex < 3; rowIndex++)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 4; i++)
                CustomElevatedButton(
                  pixelWidth: aspectRatio >= 0.56 ? width * 0.16 : width * 0.2,
                  pixelHeight:
                      rowIndex == 2 && i == 3 ? (aspectRatio >= 0.56 ? width * 0.12 : width * 0.14) : (aspectRatio >= 0.56 ? width * 0.16 : width * 0.2),
                  shape: rowIndex == 2 && i == 3 ? null : const CircleBorder(),
                  borderRadius: 8,
                  backgroundColor: rowIndex == 2 && i == 3 ? CalculatorColors.lavender : CalculatorColors.lightGray,
                  onClick: () {},
                  child: rowIndex == 2 && i == 3
                      ? RichText(
                          text: const TextSpan(text: "S⇔D", style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600)),
                        )
                      : RichText(
                          text: TextSpan(
                              text: CalculatorWidgetsData.advancedPanelKeys[rowIndex * 4 + i + 1]['name'],
                              style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                )
            ],
          )
      ],
    );
  }
}
