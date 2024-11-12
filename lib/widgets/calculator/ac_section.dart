import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/common/constant_widgets.dart';
import 'package:calculator_app/common/custom_elevated_button.dart';
import 'package:calculator_app/widgets/calculator/calculator_widgets_data/calculator_widgets_data.dart';
import 'package:calculator_app/widgets/calculator/functions/button_functions.dart';
import 'package:calculator_app/widgets/calculator/states/display_panel_state.dart';
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
        children: List.generate(
            4,
            (index) => CustomElevatedButton(
                  pixelWidth: width * 0.2,
                  pixelHeight: width * 0.2,
                  shape: const CircleBorder(),
                  backgroundColor: index == 2 || index == 3 ? (index == 2 ? CalculatorColors.paleYellow : CalculatorColors.lightPink) : const Color(0xFFD9D9D9),
                  onClick: () {
                    // ButtonFunctions.onAcSectionClicked(index: index,);
                  },
                  child: ConstantWidgets.text(context, CalculatorWidgetsData.acSectionKeys[index]['name'], color: Colors.black, fontWeight: FontWeight.w600),
                )),
      ),
    );
  }
}
