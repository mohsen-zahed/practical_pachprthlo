import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/constants/fonts.dart';
import 'package:practical_pachprthlo/features/data/models/d-font_model/font_model.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences_const.dart';

class FontProvider extends ChangeNotifier {
  String fontFamily;
  double fontFamilySize;
  List<String> persianFontsList = [
    FontModel.bTitrFont.fontFamily,
  ];
  List<String> englishFontsList = [
    FontModel.exarrosFont.fontFamily,
    FontModel.helvitcaFont.fontFamily,
    FontModel.fridayCuteFont.fontFamily,
  ];

  FontProvider({
    this.fontFamily = defaultAppFont,
    this.fontFamilySize = defaultAppFontSize,
  }) {
    getFontFamily();
  }

  Future<void> updateFontFamily(String inputFontName, double inputFontFamilySize) async {
    await MySharedPreferences.instance.storeToSharedPreferences(fontFamilyKey, inputFontName);
    await MySharedPreferences.instance.storeToSharedPreferences(fontFamilySizeKey, inputFontFamilySize.toString());
    fontFamily = inputFontName;
    fontFamilySize = inputFontFamilySize;
    notifyListeners();
  }

  Future<void> getFontFamily() async {
    final String? fontFamily = await MySharedPreferences.instance.getFromSharedPreferences(fontFamilyKey);
    if (fontFamily != null) {
      this.fontFamily = fontFamily;
    }
    notifyListeners();
  }
}
