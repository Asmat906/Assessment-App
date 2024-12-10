import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
//text widget

Widget text(text,
    {var fontSize,
    Color? textColor,
    var fontFamily,
    var isCentered = false,
    var maxLine,
    var decoration,
    var overFlow,
    TextAlign? align,
    var latterSpacing = 0.5,
    bool textAllCaps = false,
    var isLongText = false,
    bool lineThrough = false,
    var fontWeight}) {
  return Text(
    textAllCaps ? text! : text!,
    textAlign: align,
    maxLines: isLongText ? null : maxLine,
    overflow: overFlow,
    style: TextStyle(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: textColor ?? black,
      // height: 1.5,
      letterSpacing: latterSpacing,
      decoration: decoration,
    ),
  );
}