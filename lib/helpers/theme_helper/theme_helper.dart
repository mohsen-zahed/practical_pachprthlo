import 'package:flutter/material.dart';

class ThemeHelper {
  ThemeHelper._();
  static bool isThemeLight(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.light;
  }
}
