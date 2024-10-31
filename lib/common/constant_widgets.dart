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
}
