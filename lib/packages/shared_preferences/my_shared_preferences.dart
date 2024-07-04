import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static MySharedPreferences? _instance;
  MySharedPreferences._();
  static MySharedPreferences get instance {
    _instance ??= MySharedPreferences._();
    return _instance!;
  }

  Future<void> storeLanguage(String languageCode) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(languageKey, languageCode);
  }

  Future<String?> getLanguage() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(languageKey);
  }

  Future<void> storeTheme(ThemeMode themeCode) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(themeKey, themeCode.toString());
  }

  Future<ThemeMode?> getTheme() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return _themeModeFromString(sharedPreferences.getString(themeKey));
  }

  ThemeMode _themeModeFromString(String? themeModeString) {
    if (themeModeString != null) {
      switch (themeModeString) {
        case 'ThemeMode.light':
          return ThemeMode.light;
        default:
          return ThemeMode.dark;
      }
    } else {
      return ThemeMode.light;
    }
  }
}
