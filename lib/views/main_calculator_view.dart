import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/widgets/calculator/advanced_panel.dart';
import 'package:calculator_app/widgets/calculator/display_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainCalculatorView extends StatelessWidget {
  const MainCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Get.size.width;
    final double screenHeight = Get.size.height;
    final double statusBarHeight = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(systemNavigationBarColor: Get.theme.scaffoldBackgroundColor, statusBarColor: Colors.transparent),
      child: Scaffold(
        body: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            children: [
              SizedBox(
                height: statusBarHeight,
              ),
              SizedBox(
                height: screenHeight * 0.45,
                width: screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    //Display Panel of Calculator
                    DisplayPanel(height: screenHeight * 0.17, width: screenWidth,),

                    //Advanced Functions Panel
                    AdvancedPanel(height: screenHeight * 0.23, width: screenWidth),

                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
                child: SizedBox(
                  height: screenHeight * 0.55 - statusBarHeight,
                  width: screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ColoredBox(
                          color: Colors.lightBlue,
                          child: SizedBox(
                            width: screenWidth * 0.64,
                            height: screenHeight - statusBarHeight/2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ColoredBox(
                                  color: Colors.orange,
                                  child: SizedBox(
                                    width: screenWidth * 0.64,
                                    height: screenHeight * 0.09,
                                  ),
                                ),
                                ColoredBox(
                                  color: Colors.purple,
                                  child: SizedBox(
                                    width: screenWidth * 0.65,
                                    height: screenHeight * 0.41,
                                  ),
                                ),
                              ],
                            ),
                          )),

                      ColoredBox(
                          color: Colors.black,
                          child: SizedBox(
                            width: screenWidth * 0.24,
                            height: screenHeight - statusBarHeight/2,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ColoredBox(
                                    color: Colors.green,
                                    child: SizedBox(
                                      width: screenWidth * 0.24,
                                    ),
                                  ),
                                ),
                                ColoredBox(
                                  color: Colors.indigo,
                                  child: SizedBox(
                                    width: screenWidth * 0.24,
                                    height: screenHeight * 0.08,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
