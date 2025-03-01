enum FontModel {
  bTitrFont(
    'BTitr',
    'assets/images/icons/font_icons/font_icon.png',
    24,
    'B Titr',
  ),
  exarrosFont(
    'Exarros',
    'assets/images/icons/font_icons/font_icon.png',
    20,
    'Exarros',
  ),
  helvitcaFont(
    'Helvitca',
    'assets/images/icons/font_icons/font_icon.png',
    24,
    'Helvitca',
  ),
  fridayCuteFont(
    'FridayCute',
    'assets/images/icons/font_icons/font_icon.png',
    24,
    'FridayCute',
  );

  final String fontFamily;
  final String iconPath;
  final double fontSize;
  final String name;
  const FontModel(this.fontFamily, this.iconPath, this.fontSize, this.name);
}
