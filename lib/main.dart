import 'package:calculator_app/app.dart';
import 'package:calculator_app/controller/state/ui_values_controller.dart';
import 'package:calculator_app/data/hive_data/hive_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveData.initHiveData();
  Get.put<UiValuesController>(UiValuesController()).initializeAppTheme();
  
  runApp(const App());
}

