import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';
import 'package:practical_pachprthlo/gen/assets.gen.dart';

enum ColorModel {
  primaryColor(
    kPrimaryColor,
    Assets.colorIcon,
    'Primary Color',
  ),
  secondaryColor(
    kSecondaryColor,
    Assets.colorIcon,
    'Secondary Color',
  );

  final Color color;
  final AssetGenImage colorPath;
  final String name;
  const ColorModel(this.color, this.colorPath, this.name);
}
