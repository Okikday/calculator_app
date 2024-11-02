import 'package:calculator_app/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiValuesController extends GetxController{
  Rx<ThemeData> lightTheme = ThemeData().obs;
  Rx<ThemeData> darkTheme = ThemeData().obs;

  void initializeAppTheme(){
    lightTheme.value = darkTheme.value = Constants.defaultAppTheme;
    
  }

  void setAppFont(String font){

  }

}