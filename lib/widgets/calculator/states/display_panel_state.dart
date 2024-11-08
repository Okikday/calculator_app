import 'dart:developer';

import 'package:calculator_app/widgets/calculator/functions/calculations_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


final DisplayPanelState displayPanelState = Get.put<DisplayPanelState>(DisplayPanelState());

class DisplayPanelState extends GetxController {
  final Rx<FocusNode> inputFocusNode = FocusNode().obs;
  final Rx<TextEditingController> inputController = TextEditingController().obs;
  final Rx<ScrollController> inputScrollController = ScrollController().obs;

  Rx<String> evalExprResult = "0".obs;

  @override
  void onInit() {
    super.onInit();
    inputController.value.addListener(scrollToEnd);
    inputController.value.addListener(calculateExpr);
  }

  @override
  void onClose() {
    inputController.value.removeListener(scrollToEnd);
    inputController.value.removeListener(calculateExpr);
    super.onClose();
  }


  void scrollToEnd() {
    if (inputScrollController.value.hasClients) {
      inputScrollController.value
          .animateTo(inputScrollController.value.position.maxScrollExtent + 16, duration: const Duration(milliseconds: 75), curve: Curves.decelerate);
      if (inputController.value.text.isEmpty) {
        inputScrollController.value.jumpTo(inputScrollController.value.position.maxScrollExtent);
      }
    }
  }

  void calculateExpr() {
    evalExprResult.value = CalculationsFunctions.evaluateExpression(inputController.value.text);
  }

}
