import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayPanelState extends GetxController{
  
  final Rx<FocusNode> inputFocusNode = FocusNode().obs;
  final Rx<TextEditingController> inputController = TextEditingController().obs;

}