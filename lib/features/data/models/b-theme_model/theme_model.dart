import 'package:flutter/material.dart';

enum Themes {
  light(
    ThemeMode.light,
    'assets/light_mode_icon.png',
    'Light mode',
  ),
  dark(
    ThemeMode.dark,
    'assets/dark_mode_icon.png',
    'Dark mode',
  ),
  system(
    ThemeMode.system,
    'assets/system_mode_icon.png',
    'System',
  );

  final ThemeMode themeMode;
  final String iconPath;
  final String name;

  const Themes(
    this.themeMode,
    this.iconPath,
    this.name,
  );
}
