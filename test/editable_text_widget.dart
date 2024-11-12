import 'package:flutter/material.dart';

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
  const EditableTextWidget({Key? key}) : super(key: key);

  @override
  _EditableTextWidgetState createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  // Shared controller and focus node for back and front text fields
  static final TextEditingController backController = TextEditingController();
  static final FocusNode backFocusNode = FocusNode();
  static final ScrollController scrollController = ScrollController();

  // Tracking positions and managing dynamic `frontTextField` placements
  final List<Map<String, dynamic>> frontTextFieldElements = [];
  final Map<int, Map<String, dynamic>> generalPositioning = {}; // Track element placements, positioning, etc.

  static const double height = 100;
  static const double width = 320;

  @override
  void initState() {
    super.initState();
    backFocusNode.addListener(() => _updateGeneralPositioning());
  }

  // Background main text field widget
  Widget backTextField() {
    return EditableText(
      controller: backController,
      focusNode: backFocusNode,
      style: const TextStyle(fontSize: 24, color: Colors.black),
      cursorColor: Colors.blue.withOpacity(0.5),
      backgroundCursorColor: Colors.white,
      textAlign: TextAlign.left,
      scrollController: scrollController,
      keyboardType: TextInputType.none,
      toolbarOptions: const ToolbarOptions(copy: false, cut: false, paste: false, selectAll: false),
    );
  }

  // Special Input Text Field Widget (for placements like subscript, superscript)
  Widget frontTextField({
    required TextFieldPlacement placement,
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    return Positioned(
      top: _getVerticalOffset(placement),
      left: _getHorizontalOffset(placement),
      child: SizedBox(
        height: 30,
        width: 80,
        child: EditableText(
          controller: controller,
          focusNode: focusNode,
          style: const TextStyle(fontSize: 16, color: Colors.red),
          cursorColor: Colors.red.withOpacity(0.5),
          backgroundCursorColor: Colors.white,
          textAlign: TextAlign.center,
          scrollController: scrollController,
          toolbarOptions: const ToolbarOptions(copy: false, cut: false, paste: false, selectAll: false),
        ),
      ),
    );
  }

  // Position offset calculations
  double _getVerticalOffset(TextFieldPlacement placement) {
    switch (placement) {
      case TextFieldPlacement.topSuperscript:
        return 10;
      case TextFieldPlacement.bottomSubscript:
        return height - 40;
      case TextFieldPlacement.centerLeft:
      case TextFieldPlacement.centerRight:
        return height / 2 - 15;
      default:
        return height / 2 - 15; // Default center
    }
  }

  double _getHorizontalOffset(TextFieldPlacement placement) {
    switch (placement) {
      case TextFieldPlacement.leftSubscript:
      case TextFieldPlacement.leftSuperScript:
        return 10;
      case TextFieldPlacement.rightSubscript:
      case TextFieldPlacement.rightSuperscript:
        return width - 90;
      case TextFieldPlacement.centerLeft:
        return width / 4;
      case TextFieldPlacement.centerRight:
        return (width / 4) * 3;
      default:
        return width / 2 - 40; // Default center
    }
  }

  // Add a special input with specific placement
  void addSpecialInput(TextFieldPlacement placement, String label) {
    setState(() {
      // Add placeholder in backTextField at cursor position
      int cursorPosition = backController.selection.baseOffset;
      String currentText = backController.text;
      String placeholder = "[$label]"; // placeholder for special input

      backController.text = currentText.substring(0, cursorPosition) +
          placeholder +
          currentText.substring(cursorPosition);

      // Add frontTextField element
      frontTextFieldElements.add({
        'placement': placement,
        'controller': TextEditingController(),
        'focusNode': FocusNode(),
        'label': label,
        'placeholderPosition': cursorPosition
      });

      _updateGeneralPositioning();
    });
  }

  // Add regular text input to backTextField
  void addNormalInput(String text) {
    int cursorPosition = backController.selection.baseOffset;
    backController.text = backController.text.substring(0, cursorPosition) +
        text +
        backController.text.substring(cursorPosition);

    backController.selection = TextSelection.collapsed(
      offset: cursorPosition + text.length,
    );

    _updateGeneralPositioning();
  }

  // Update `generalPositioning` map
  void _updateGeneralPositioning() {
    generalPositioning.clear();
    // Populate map based on current elements for tracking
    for (int i = 0; i < frontTextFieldElements.length; i++) {
      var element = frontTextFieldElements[i];
      generalPositioning[i] = {
        'placement': element['placement'],
        'controller': element['controller'],
        'focusNode': element['focusNode'],
        'type': 'special',
        'label': element['label']
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          backTextField(),
          ...frontTextFieldElements.map(
            (element) => frontTextField(
              placement: element['placement'],
              controller: element['controller'],
              focusNode: element['focusNode'],
            ),
          ),
        ],
      ),
    );
  }
}
