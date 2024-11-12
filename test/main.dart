import 'package:flutter/material.dart';

import 'test_main.dart';

void main() async{
  runApp(MaterialApp(
    home: EditableTextWidget(),
  ));
}



enum TextFieldPlacement {
  rightSubscript,
  rightSuperscript,
  leftSubscript,
  leftSuperScript,
  bottomSubscript,
  topSuperscript,
  centerLeft,
  centerRight,
}

class EditableTextWidget extends StatefulWidget {
  const EditableTextWidget({super.key});

  @override
  State<EditableTextWidget> createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  static final TextEditingController backController = TextEditingController();
  static final FocusNode backFocusNode = FocusNode();
  final List<SpecialInput> specialInputs = [];
  static final ScrollController scrollController = ScrollController();

  static const double height = 100;
  static const double width = 320;

  @override
  void initState() {
    super.initState();
    backFocusNode.addListener(() {
      if (backFocusNode.hasFocus) {
        setState(() {});
      }
    });
  }

  void addNormalInput(String text) {
    setState(() {
      backController.text += text;
      backController.selection = TextSelection.fromPosition(
        TextPosition(offset: backController.text.length),
      );
    });
  }

  void addSpecialInput(String name, List<EditableText> elements) {
    setState(() {
      final specialInput = SpecialInput(name: name, elements: elements);
      specialInputs.add(specialInput);
      backController.text += ' '; // Placeholder for special input
    });
  }

  void deleteElement() {
    if (backController.selection.baseOffset > 0) {
      // Logic to delete appropriate elements
      int cursorPosition = backController.selection.baseOffset;
      // Check which special input is closest to the cursor
      for (var input in specialInputs) {
        if (cursorPosition >= input.offset) {
          // Remove input based on cursor position
          setState(() {
            specialInputs.remove(input);
            backController.text = backController.text.substring(0, cursorPosition - 1) + backController.text.substring(cursorPosition);
            backController.selection = TextSelection.fromPosition(TextPosition(offset: cursorPosition - 1));
          });
          return;
        }
      }
      // If no special input found, simply delete character
      backController.text = backController.text.substring(0, cursorPosition - 1) + backController.text.substring(cursorPosition);
    }
  }

  Map<String, dynamic> getTextAtPosition(int position) {
    for (var input in specialInputs) {
      if (position < input.offset) {
        return input.toMap();
      }
    }
    return {'text': backController.text};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editable Text Widget")),
      body: Column(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Stack(
              children: [
                EditableText(
                  controller: backController,
                  focusNode: backFocusNode,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                  cursorColor: Colors.blue.withOpacity(0.5),
                  backgroundCursorColor: Colors.white,
                  toolbarOptions: const ToolbarOptions(copy: false, cut: false, paste: false, selectAll: false),
                ),
                ListView.builder(
                  controller: scrollController,
                  itemCount: specialInputs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: specialInputs[index].build(),
                    );
                  },
                ),
              ],
            ),
          ),
          Wrap(
            children: [
              ElevatedButton(onPressed: () => addNormalInput("x"), child: const Text("x")),
              ElevatedButton(onPressed: () => addNormalInput("y"), child: const Text("y")),
              ElevatedButton(onPressed: () => addNormalInput("z"), child: const Text("z")),
              ElevatedButton(onPressed: () => addSpecialInput("∑", []), child: const Text("∑")),
              ElevatedButton(onPressed: () => addSpecialInput("∞", []), child: const Text("∞")),
              ElevatedButton(onPressed: () => addSpecialInput("√", []), child: const Text("√")),
              ElevatedButton(onPressed: () => addSpecialInput("∫", []), child: const Text("∫")),
              ElevatedButton(onPressed: deleteElement, child: const Icon(Icons.backspace)),
              ElevatedButton(onPressed: () => backController.clear(), child: const Icon(Icons.clear)),
              ElevatedButton(onPressed: () => addSpecialInput("²", []), child: const Text("²")),
              ElevatedButton(onPressed: () => addSpecialInput("³", []), child: const Text("³")),
              // Add more buttons as needed
            ],
          ),
        ],
      ),
    );
  }
}

class SpecialInput {
  final String name;
  final List<EditableText> elements;
  final int offset;

  SpecialInput({required this.name, required this.elements}) : offset = 0;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'elements': elements.map((e) => e.controller.text).toList(),
    };
  }

  Widget build() {
    return Stack(
      children: elements.map((e) {
        return Positioned(
          // Add logic for positioning based on TextFieldPlacement
          child: e,
        );
      }).toList(),
    );
  }
}
