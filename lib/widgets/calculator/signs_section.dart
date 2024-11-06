import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/common/constant_widgets.dart';
import 'package:calculator_app/common/custom_elevated_button.dart';
import 'package:calculator_app/widgets/calculator/calculator_widgets_data/calculator_widgets_data.dart';
import 'package:calculator_app/widgets/calculator/functions/button_functions.dart';
import 'package:calculator_app/widgets/calculator/states/display_panel_state.dart';
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
    final DisplayPanelState displayPanelState = Get.put<DisplayPanelState>(DisplayPanelState());

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: width,
          height: height * 0.82,
          decoration: BoxDecoration(color: CalculatorColors.mediumGray, borderRadius: BorderRadius.circular(60)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index){
              return CustomElevatedButton(
                  pixelHeight: aspectRatio >= 0.56 ? width * 0.65 : width * 0.75,
                  pixelWidth: aspectRatio >= 0.56 ? width * 0.65 : width * 0.75,
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(),
                  onClick: () => ButtonFunctions.onSignsSectionClicked(index: index, displayPanelState: displayPanelState),
                  child: ConstantWidgets.text(context, CalculatorWidgetsData.signsKeys[index]['name'], color: Colors.black, fontSize: 32, fontWeight: FontWeight.w600),
                );
            }),
          ),
        ),
        CustomElevatedButton(
          pixelHeight: height * 0.15,
          pixelWidth: width,
          borderRadius: 48,
          backgroundColor: CalculatorColors.tealBlue,
          overlayColor: Colors.white.withOpacity(0.3),
          elevation: 40,
          onClick: (){},
          child: ConstantWidgets.text(context, "=", fontSize: 32, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
