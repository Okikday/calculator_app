import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:calculator_app/common/colors.dart';
import 'package:calculator_app/common/constant_widgets.dart';
import 'package:calculator_app/widgets/calculator/states/display_panel_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class DisplayPanel extends StatelessWidget {
  final double height;
  final double width;

  const DisplayPanel({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      padding: const EdgeInsets.all(12),
      height: height,
      width: width,
      decoration: BoxDecoration(color: CalculatorColors.mediumGray.withAlpha(200), borderRadius: BorderRadius.circular(24)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: height * 0.35,
            width: width,
            child: const InputTextField(),
          ),
          Container(
            height: 8,
            width: width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: CalculatorColors.lightGray),
          ),
          SizedBox(
            height: height * 0.35,
            child: Row(
              children: [
                ConstantWidgets.text(context, "= ", fontSize: 32),
                Expanded(child: Obx(() => Align(alignment: Alignment.centerRight, child: FittedBox(child: ConstantWidgets.text(context, displayPanelState.evalExprResult.value, align: TextAlign.end, fontSize: 32, color: CalculatorColors.lightGray)))))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  static EditableTextState? editableTextState;
  static Timer? _longPressTimer;
  static Offset pointerPosition = const Offset(64, 64);

  const InputTextField({super.key,});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Listener(
        onPointerDown: (event) {
          if (event.kind == PointerDeviceKind.touch && event.buttons == kPrimaryButton) {
            log("${displayPanelState.inputFocusNode.value.offset}");
            if (_longPressTimer != null) _longPressTimer?.cancel();
            editableTextState?.hideToolbar();
            _longPressTimer = Timer(const Duration(milliseconds: 500), () {
              final EditableTextState? editableTextState = displayPanelState.inputFocusNode.value.context?.findAncestorStateOfType<EditableTextState>();
              if (editableTextState != null) {
                editableTextState.showToolbar();
              }
            });
          }
        },
        onPointerUp: (event) {
          if (_longPressTimer != null) _longPressTimer?.cancel();
        },
        onPointerCancel: (event) {
          if (_longPressTimer != null) _longPressTimer?.cancel();
        },
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: EditableText(
                contextMenuBuilder: (context, editableTextState) {
                  return AdaptiveTextSelectionToolbar(
                    anchors: editableTextState.contextMenuAnchors,
                    children: [
                      // Copy option
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.all(8.0),
                        onPressed: () {
                          editableTextState.copySelection(SelectionChangedCause.longPress);
                          editableTextState.hideToolbar();
                        },
                        child: const Text('Copy'),
                      ),
      
                      // Cut option
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.all(8.0),
                        onPressed: () {
                          editableTextState.cutSelection(SelectionChangedCause.longPress);
                          editableTextState.hideToolbar();
                        },
                        child: const Text('Cut'),
                      ),
      
                      // Paste option
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.all(8.0),
                        onPressed: () async{
                          await editableTextState.pasteText(SelectionChangedCause.longPress);
                          editableTextState.hideToolbar();
                          if(context.mounted) ConstantWidgets.showFlushBar(context, "Pasted text", duration: 500,);
                        },
                        child: const Text('Paste'),
                      ),
      
                      // Select All option
                      TextSelectionToolbarTextButton(
                        padding: const EdgeInsets.all(8.0),
                        onPressed: () {
                          editableTextState.selectAll(SelectionChangedCause.longPress);
                          editableTextState.hideToolbar();
                        },
                        child: const Text('Select All'),
                      ),
                    ],
                  ).animate().fadeIn();
                },
                onTapOutside: (event) {
                  editableTextState = displayPanelState.inputFocusNode.value.context?.findAncestorStateOfType<EditableTextState>();
                  editableTextState?.hideToolbar();
                },
                textAlign: TextAlign.right,
                controller: displayPanelState.inputController.value,
                focusNode: displayPanelState.inputFocusNode.value,
                scrollController: displayPanelState.inputScrollController.value,
                autocorrect: false,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                ),
                cursorColor: Colors.blue,
                backgroundCursorColor: Colors.transparent,
                maxLines: 1,
                keyboardType: TextInputType.none,
                cursorOpacityAnimates: true,
                cursorRadius: const Radius.circular(4),
                selectionColor: Colors.blue,
                selectionHeightStyle: BoxHeightStyle.max,
                enableInteractiveSelection: true,
                selectionControls: CupertinoTextSelectionControls(),
                showSelectionHandles: true,
              )),
        ),
      ),
    );
  }
}
