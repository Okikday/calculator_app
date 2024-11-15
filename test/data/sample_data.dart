import '../state/custom_editable_text_controller.dart';

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
      'placementsAndTexts': {TextFieldPlacement.centerLeft: "1", TextFieldPlacement.centerRight: "2"}
    },
    {
      'text': "D",
      'placementsAndTexts': {TextFieldPlacement.centerLeft: "3", TextFieldPlacement.centerRight: "4"}
    },
  ];
}