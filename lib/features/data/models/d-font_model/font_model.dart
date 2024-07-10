enum FontModel {
  bTitrFont(
    'BTitr',
    'assets/images/icons/font_icons/font_icon.png',
    32,
    'B Titr',
  ),
  exarrosFont(
    'Exarros',
    'assets/images/icons/font_icons/font_icon.png',
    16,
    'Exarros',
  ),
  helvitcaFont(
    'Helvitca',
    'assets/images/icons/font_icons/font_icon.png',
    16,
    'Helvitca',
  ),
  fridayCuteFont(
    'FridayCute',
    'assets/images/icons/font_icons/font_icon.png',
    16,
    'FridayCute',
  );

  final String fontFamily;
  final String iconPath;
  final double fontSize;
  final String name;
  const FontModel(this.fontFamily, this.iconPath, this.fontSize, this.name);
}
