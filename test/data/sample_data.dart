import '../state/custom_editable_text_controller.dart';
import 'package:flutter/widgets.dart';

class SampleData {
  List<Map<String, dynamic>> keys = [
    {
      'text': "A",
    },
    {
      'text': "B",
    },
    {
      'text': "C",
      'placementsAndTexts': {Alignment.centerLeft: "1", Alignment.centerRight: "2"}
    },
    {
      'text': "D",
      'placementsAndTexts': {Alignment.centerLeft: "3", Alignment.centerRight: "4"}
    },
  ];
}