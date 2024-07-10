import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';
import 'package:practical_pachprthlo/helpers/theme_helper/color_helper.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences.dart';
import 'package:practical_pachprthlo/packages/shared_preferences/my_shared_preferences_const.dart';

class ColorProvider extends ChangeNotifier {
  Color primaryColor = kPrimaryColor;
  Color secondaryColor = kSecondaryColor;

  ColorProvider() {
    getPrimaryColor();
    getSecondaryColor();
  }

  Future<void> updatePrimaryColor(MaterialColor newPrimaryColor) async {
    await MySharedPreferences.instance.storeToSharedPreferences(primaryColorKey, ColorHelper.encodeMaterialColor(newPrimaryColor));
    primaryColor = newPrimaryColor;
    notifyListeners();
  }

  Future<void> updateSecondaryColor(MaterialColor newSecondaryColor) async {
    await MySharedPreferences.instance.storeToSharedPreferences(secondaryColorKey, ColorHelper.encodeMaterialColor(newSecondaryColor));
    secondaryColor = newSecondaryColor;
    notifyListeners();
  }

  Future<void> getPrimaryColor() async {
    final String? primaryColor = await MySharedPreferences.instance.getFromSharedPreferences(primaryColorKey);
    if (primaryColor != null) {
      MaterialColor decodedPrimaryColor = ColorHelper.decodeMaterialColor(primaryColor);
      this.primaryColor = decodedPrimaryColor[500]!;
    }
    notifyListeners();
  }

  Future<void> getSecondaryColor() async {
    final String? secondaryColor = await MySharedPreferences.instance.getFromSharedPreferences(secondaryColorKey);
    if (secondaryColor != null) {
      MaterialColor decodedSecondaryColor = ColorHelper.decodeMaterialColor(secondaryColor);
      this.secondaryColor = decodedSecondaryColor[500]!;
    }
    notifyListeners();
  }
}
