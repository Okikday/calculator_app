import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state/custom_editable_text_controller.dart';
import 'state/custom_editable_text_functions.dart';

class CustomEditableText extends StatelessWidget {
  final double height;
  final double width;
  final TextStyle textStyle;

  const CustomEditableText({
    super.key,
    this.height = 100,
    this.width = 400,
    this.textStyle = const TextStyle(fontSize: 100 * 0.8, color: Colors.white,),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            color: Colors.lightBlue.withOpacity(0.1),
          ),
          height: height,
          width: width,
          clipBehavior: Clip.hardEdge,
          child: GestureDetector(
            onTapDown: (details) {
              log(details.toString());
            },
            child: Stack(
              children: [
                Obx(() => ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: customEditableTextController.allElements.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final element = customEditableTextController.allElements[index];
                        log("element: $element");
                        if (customEditableTextController.allElements.isEmpty) {
                          return const SizedBox(
                            child: Text(
                              "Empty rn",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          );
                        } 
                        if(element is String) {
                          return CustomEditableTextFunctions.makeNormalTextWidget(text: element, textStyle: textStyle);
                        }
                        return const SizedBox(
                            child: Text(
                              "Default Text",
                              style: TextStyle(color: Colors.yellow, fontSize: 16),
                            ),
                          );
                      }),
                ),

                //Cursor
                // height prone to change
                Container(
                  width: 2,
                  height: height * 0.95,
                  color: Colors.orange,
                )
              ],
            ),
          ));
  }
}
