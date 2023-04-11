import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/tocolor.dart';
import 'package:foodapp/core/_config.dart' as cnf;


class MyText {
  static Widget baseText(
      {String text = 'base',
      dynamic size = 18,
      FontWeight fontWeight = FontWeight.w500,
      String color = cnf.colorBlack,
      TextAlign? textAlign,
      String fontFamily = 'Poppins',
      TextDecoration? decoration,
      int? maxLine}) {
    return AutoSizeText(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      style: TextStyle(
        fontFamily: fontFamily,
        //overflow: TextOverflow.ellipsis,
        decoration: decoration,
        fontSize: size.toDouble(),
        fontWeight: fontWeight,
        color: color.toColor(),
      ),
    );
  }

  static TextStyle textStyle(
      {dynamic size = 18,
      FontWeight fontWeight = FontWeight.w500,
      String color = cnf.colorBlack,
      TextAlign? textAlign,
      String fontFamily = 'Poppins',
      TextDecoration? decoration}) {
    return TextStyle(
        fontFamily: fontFamily,
        decoration: decoration,
        fontSize: size.toDouble(),
        fontWeight: fontWeight,
        color: color.toColor());
  }
}
