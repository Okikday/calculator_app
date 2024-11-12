// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: EditableTextTestScreen(),
//   ));
// }

// enum TextFieldPlacement {
//   rightSubscript,
//   rightSuperscript,
//   leftSubscript,
//   leftSuperScript,
//   bottomSubscript,
//   topSuperscript,
//   centerLeft,
//   centerRight,
// }

// class EditableTextTestScreen extends StatefulWidget {
//   const EditableTextTestScreen({Key? key}) : super(key: key);

//   @override
//   _EditableTextTestScreenState createState() => _EditableTextTestScreenState();
// }

// class _EditableTextTestScreenState extends State<EditableTextTestScreen> {
//   final EditableTextWidget editableTextWidget = EditableTextWidget();

//   // List of special symbols for testing
//   final List<String> symbols = ['∑', '∫', 'π', '√', '∞', 'θ', 'α', 'β', 'γ', 'δ', 'λ', 'μ', 'σ'];

//   // Current placement setting for special symbols
//   TextFieldPlacement currentPlacement = TextFieldPlacement.centerRight;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("EditableText Test Interface")),
//       body: Column(
//         children: [
//           // EditableTextWidget area
//           Expanded(
//             flex: 2,
//             child: Center(child: editableTextWidget),
//           ),
//           // Special characters buttons
//           Expanded(
//             child: Wrap(
//               spacing: 10,
//               runSpacing: 10,
//               children: symbols.map((symbol) {
//                 return ElevatedButton(
//                   onPressed: () => editableTextWidget.addSpecialInput(currentPlacement, symbol),
//                   child: Text(symbol),
//                 );
//               }).toList(),
//             ),
//           ),
//           // Placement options buttons
//           Expanded(
//             child: Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: [
//                 _placementButton("Top Superscript", TextFieldPlacement.topSuperscript),
//                 _placementButton("Bottom Subscript", TextFieldPlacement.bottomSubscript),
//                 _placementButton("Center Left", TextFieldPlacement.centerLeft),
//                 _placementButton("Center Right", TextFieldPlacement.centerRight),
//                 _placementButton("Left Superscript", TextFieldPlacement.leftSuperScript),
//                 _placementButton("Right Superscript", TextFieldPlacement.rightSuperscript),
//               ],
//             ),
//           ),
//           // Action buttons: delete, clear, add normal input
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => editableTextWidget.addNormalInput("Test Text"),
//                   child: const Text("Add Text"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => editableTextWidget.deleteContent(),
//                   child: const Text("Delete"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => editableTextWidget.clearAll(),
//                   child: const Text("Clear All"),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper to create a button for each placement option
//   ElevatedButton _placementButton(String label, TextFieldPlacement placement) {
//     return ElevatedButton(
//       onPressed: () => setState(() {
//         currentPlacement = placement;
//       }),
//       child: Text(label),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: currentPlacement == placement ? Colors.blue : Colors.grey,
//       ),
//     );
//   }
// }

// class EditableTextWidget extends StatefulWidget {
//   @override
//   _EditableTextWidgetState createState() => _EditableTextWidgetState();
// }

// class _EditableTextWidgetState extends State<EditableTextWidget> {
//   final TextEditingController backController = TextEditingController();
//   final FocusNode backFocusNode = FocusNode();

//   final ScrollController scrollController = ScrollController();

//   final List<Map<String, dynamic>> frontTextFieldElements = [];

//   @override
//   void initState() {
//     super.initState();
//     scrollController.addListener(_syncScroll);
//   }

//   void _syncScroll() {
//     // Sync scrolling if needed
//   }

//   void addNormalInput(String text) {
//     backController.text += text;
//   }

//   void addSpecialInput(TextFieldPlacement placement, String symbol) {
//     setState(() {
//       frontTextFieldElements.add({
//         'placement': placement,
//         'symbol': symbol,
//         'controller': TextEditingController(text: symbol),
//         'focusNode': FocusNode(),
//       });
//       backController.text += ' ';  // Add a placeholder in back text
//     });
//   }

//   void deleteContent() {
//     if (backController.selection.baseOffset > 0) {
//       final cursorPos = backController.selection.baseOffset;
//       setState(() {
//         backController.text = backController.text.substring(0, cursorPos - 1) +
//             backController.text.substring(cursorPos);
//       });
//     }
//   }

//   void clearAll() {
//     setState(() {
//       backController.clear();
//       frontTextFieldElements.clear();
//     });
//   }

//   @override
//   void dispose() {
//     backController.dispose();
//     backFocusNode.dispose();
//     scrollController.dispose();
//     for (var element in frontTextFieldElements) {
//       element['controller'].dispose();
//       element['focusNode'].dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       width: 320,
//       child: Stack(
//         children: [
//           Positioned.fill(
//             child: EditableText(
//               controller: backController,
//               focusNode: backFocusNode,
//               style: TextStyle(fontSize: 24, color: Colors.black),
//               cursorColor: Colors.blue.withOpacity(0.5),
//               backgroundCursorColor: Colors.white,
//               onChanged: (text) => setState(() {}),
//             ),
//           ),
//           ListView.builder(
//             controller: scrollController,
//             itemCount: frontTextFieldElements.length,
//             itemBuilder: (context, index) {
//               final element = frontTextFieldElements[index];
//               final placement = element['placement'];
//               final controller = element['controller'] as TextEditingController;
//               final focusNode = element['focusNode'] as FocusNode;

//               return Positioned(
//                 top: placement == TextFieldPlacement.topSuperscript ? 0 : null,
//                 bottom: placement == TextFieldPlacement.bottomSubscript ? 0 : null,
//                 left: placement == TextFieldPlacement.leftSubscript ? 0 : null,
//                 right: placement == TextFieldPlacement.rightSubscript ? 0 : null,
//                 child: EditableText(
//                   controller: controller,
//                   focusNode: focusNode,
//                   style: TextStyle(fontSize: 16, color: Colors.red),
//                   cursorColor: Colors.red.withOpacity(0.5),
//                   backgroundCursorColor: Colors.white,
//                   onChanged: (text) => setState(() {}),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
