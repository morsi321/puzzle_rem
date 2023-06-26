import 'package:flutter/material.dart';

class Sizer {
  static final _mq = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  static final double _screenWidth = _mq.size.width;
  static final double _screenHeight = _mq.size.height;
  static final double _scaleText = _screenWidth / 480;
}

extension Responsive on num {
  double get w => this / 100 * Sizer._screenWidth;
  double get h => this / 100 * Sizer._screenHeight;
  double get sp => this * Sizer._scaleText;
}
