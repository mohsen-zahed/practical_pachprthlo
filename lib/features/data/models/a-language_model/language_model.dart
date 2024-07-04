import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/gen/assets.gen.dart';

enum Languages {
  persian(
    Locale('fa'),
    Assets.afgFlag,
    'Persian',
  ),
  english(
    Locale('en'),
    Assets.engFlag,
    'English',
  );

  final Locale locale;
  final AssetGenImage iconPath;
  final String name;

  const Languages(this.locale, this.iconPath, this.name);
}
