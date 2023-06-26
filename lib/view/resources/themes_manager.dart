import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_manager.dart';

ThemeData getLightTheme() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      foregroundColor: ColorManager.black,
      backgroundColor: ColorManager.white,
      elevation: 0,
    ),
  );
}
