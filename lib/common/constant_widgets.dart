import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ConstantWidgets{
    //Medium sized text
  static Text text(
    BuildContext context,
    String? text, {
    double fontSize = 12,
    double adjustSize = 0,
    Color? color,
    Color? darkColor,
    TextAlign? align,
    bool invertColor = false,
    TextOverflow? overflow = TextOverflow.visible,
    String? fontFamily,
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fonstStyle = FontStyle.normal,
    TextDecoration textDecoration = TextDecoration.none,
    Color decorationColor = Colors.black,
    List<Shadow> shadows = const [],
  }) {
    if (darkColor != null && MediaQuery.of(context).platformBrightness == Brightness.dark) color = darkColor;
    return Text(
      text ?? "",
      style: TextStyle(
        color: color ??
            (MediaQuery.of(context).platformBrightness == Brightness.dark
                ? (invertColor == true ? Colors.black : Colors.white)
                : (invertColor == true ? Colors.white : Colors.black)),
        fontSize: fontSize + adjustSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontStyle: fonstStyle,
        decoration: textDecoration,
        decorationColor: decorationColor,
        shadows: shadows,
      ),
      textAlign: align ?? TextAlign.start,
      overflow: overflow,
    );
  }

  static void showFlushBar(BuildContext context, String msg, {
    int duration = 1500,
    int animDuration = 500,
    Color bgColor = const Color.fromARGB(187, 0, 0, 0),
    Color? msgColor,
    double? msgTextSize,
    EdgeInsets margin = const EdgeInsets.fromLTRB(20, 0, 20, 20),
    EdgeInsets padding = const EdgeInsets.all(16),
    double borderRadius = 64,
    FlushbarPosition position = FlushbarPosition.BOTTOM,
    double barBlur = 4,
  }) {
    if (context.mounted) {
      Flushbar(
        message: msg,
        messageColor: msgColor,
        messageSize: msgTextSize,
        duration: Duration(milliseconds: duration),
        animationDuration: Duration(milliseconds: animDuration),
        flushbarPosition: position,
        margin: margin,
        borderRadius: BorderRadius.circular(borderRadius),
        backgroundColor: bgColor,
        padding: padding,
        barBlur: barBlur,
      ).show(context);
    }
  }
}
