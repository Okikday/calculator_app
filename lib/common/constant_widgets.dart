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
    FlushbarPosition position = FlushbarPosition.BOTTOM,
  }) {
    if (context.mounted) {
      Flushbar(
        message: msg,
        duration: Duration(milliseconds: duration),
        animationDuration: const Duration(milliseconds: 500),
        flushbarPosition: position,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        borderRadius: BorderRadius.circular(64),
        showProgressIndicator: true,
        backgroundColor: Colors.black.withOpacity(0.9),
        padding: const EdgeInsets.all(16),
      ).show(context);
    }
  }
}
