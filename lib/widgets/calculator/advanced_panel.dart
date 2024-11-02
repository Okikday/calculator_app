import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/common/constant_widgets.dart';
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
      margin: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.04),
      padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.04),
      height: height,
      width: width,
      decoration: BoxDecoration(color: CalculatorColors.mediumGray.withAlpha(200), borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        children: [
        SizedBox(
          height: height - height * 0.04,
          width: width * 0.66 - width * 0.04,
          child: AdvancedFuncsGridView(width: width * 0.66 - width * 0.04, height: height - height * 0.04),
        ),
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Container(color: Colors.yellow, height: height * 0.2, width: width * 0.4,),
             Container(color: Colors.blueGrey, height: height * 0.2, width: width * 0.4,),
          ],),
        ),
        Container(width: width, height: width, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),)
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
    return GridView.builder(
        itemCount: 12,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 1, mainAxisSpacing: height * 0.05, crossAxisSpacing: width * 0.66 * 0.05),
        itemBuilder: (context, index) => Container(
          alignment: Alignment.center,
              width: width * 0.15,
              height: width * 0.15,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: ConstantWidgets.text(context, index.toString(), color: Colors.black),
            ));
  }
}
