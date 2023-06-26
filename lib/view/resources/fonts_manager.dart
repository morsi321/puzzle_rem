import 'package:flutter/material.dart';
import 'package:puzzle_game/view/resources/color_manager.dart';
import 'package:puzzle_game/view/resources/sizer.dart';

class FontSize {
  static final double s12 = 12.sp;
  static final double s14 = 14.sp;
  static final double s16 = 16.sp;
  static final double s18 = 18.sp;
  static final double s20 = 20.sp;
  static final double s22 = 22.sp;
  static final double s26 = 26.sp;
}

TextStyle _getTextStyle(Color? color, double? fontSize, FontWeight fontWeight) {
  fontSize ??= FontSize.s16;
  color ??= ColorManager.black;
  return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
}

TextStyle getRegularTextStyle({Color? color, double? fontSize}) {
  return _getTextStyle(color, fontSize, FontWeight.w400);
}
