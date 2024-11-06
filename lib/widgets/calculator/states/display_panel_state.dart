import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayPanelState extends GetxController{
  
  final Rx<FocusNode> inputFocusNode = FocusNode().obs;
  final Rx<TextEditingController> inputController = TextEditingController().obs;
  final Rx<ScrollController> inputScrollController = ScrollController().obs;

  @override
  void onInit() {
    super.onInit();
    inputController.value.addListener(scrollToEnd);
  }

  void scrollToEnd() {
    if (inputScrollController.value.hasClients) {
      inputScrollController.value.animateTo(inputScrollController.value.position.maxScrollExtent + 16, duration: const Duration(milliseconds: 75), curve: Curves.decelerate);
      if(inputController.value.text.isEmpty){
        inputScrollController.value.jumpTo(inputScrollController.value.position.maxScrollExtent);
      }
    }
  }

  @override
  void onClose() {
    inputController.value.removeListener(scrollToEnd);
    super.onClose();
  }

  

}