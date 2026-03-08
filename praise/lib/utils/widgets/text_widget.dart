// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:flutter/material.dart';

Widget text(
  String text, {
  var fontSize = 15.0,
  Color? textColor,
  var fontFamily,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
  bool isItalic = false,
  bool isBold = false,
}) {
  return Text(
    textAllCaps ? text.toUpperCase() : text,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.fade,
    style: TextStyle(
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: fontFamily ?? null,
      fontSize: fontSize,
      color: textColor ?? Colors.black,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}
