import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences_const.dart';

class FontProvider extends ChangeNotifier {
  String persianFont = 'B Titr';
  double persianFontSize = 32;
  String englishFont = 'Exarros';
  double englishFontSize = 16;

  FontProvider() {
    getPersianFont();
    getEnglishFont();
  }

  Future<void> updatePersianFont(String fontName, double persianFontSize) async {
    await MySharedPreferences.instance.storeToSharedPreferences(persianFontFamilyKey, fontName);
    await MySharedPreferences.instance.storeToSharedPreferences(persianFontSizeKey, persianFontSize.toString());
    persianFont = fontName;
    persianFontSize = persianFontSize;
    notifyListeners();
  }

  Future<void> updateEnglishFont(String fontName, double englishFontSize) async {
    await MySharedPreferences.instance.storeToSharedPreferences(englishFontFamilyKey, fontName);
    await MySharedPreferences.instance.storeToSharedPreferences(englishFontSizeKey, englishFontSize.toString());
    englishFont = fontName;
    englishFontSize = englishFontSize;
    notifyListeners();
  }

  Future<void> getPersianFont() async {
    final String? persianFont = await MySharedPreferences.instance.getFromSharedPreferences(persianFontFamilyKey);
    if (persianFont != null) {
      this.persianFont = persianFont;
    }
    notifyListeners();
  }

  Future<void> getEnglishFont() async {
    final String? englishFont = await MySharedPreferences.instance.getFromSharedPreferences(englishFontFamilyKey);
    if (englishFont != null) {
      this.englishFont = englishFont;
    }
    notifyListeners();
  }
}
