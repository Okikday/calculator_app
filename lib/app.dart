import 'package:calculator_app/controller/state/ui_values_controller.dart';
import 'package:calculator_app/views/main_calculator_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final UiValuesController uiValuesController = Get.put(UiValuesController());
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      title: "Calculator App",
      debugShowCheckedModeBanner: false,
      theme: uiValuesController.lightTheme.value,
      darkTheme: uiValuesController.darkTheme.value,
      home: const MainCalculatorView().animate().scale(begin: const Offset(1.2, 1.2), end: const Offset(1, 1), duration: const Duration(milliseconds: 450), curve: Curves.decelerate),
    );
  }
}
