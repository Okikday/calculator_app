import 'dart:developer';

import 'package:calculator_app/widgets/calculator/ac_section.dart';
import 'package:calculator_app/widgets/calculator/advanced_panel.dart';
import 'package:calculator_app/widgets/calculator/display_panel.dart';
import 'package:calculator_app/widgets/calculator/numbers_section.dart';
import 'package:calculator_app/widgets/calculator/signs_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainCalculatorView extends StatelessWidget {
  const MainCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double statusBarHeight = MediaQuery.paddingOf(context).top;
    log("screenHeight: $screenHeight");
    log("screenWidth: $screenWidth");

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(systemNavigationBarColor: Get.theme.scaffoldBackgroundColor, statusBarColor: Colors.transparent),
      child: Scaffold(
        body: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Padding(
            padding: EdgeInsets.only(top: statusBarHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: screenHeight * 0.44,
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
                    height: screenHeight * 0.56 - statusBarHeight,
                    width: screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.65,
                          height: screenHeight * 0.55 - statusBarHeight/2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              //AC part
                              AcSection(height: screenHeight * 0.1 - statusBarHeight/2, width: screenWidth * 0.64),
                              
                              //Numbers section
                              NumbersSection(height: screenHeight * 0.44 - statusBarHeight/2, width: screenWidth * 0.65)
                            ],
                          ),
                        ),
            
                        SizedBox(
                          width: screenWidth * 0.24,
                          height: screenHeight * 0.545 - statusBarHeight/2,
                          child: SignsSection(height: screenHeight * 0.545 - statusBarHeight/2, width: screenWidth * 0.24)
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
