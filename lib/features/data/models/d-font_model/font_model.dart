enum FontModel {
  bTitrFont(
    'BTitr',
    'assets/color_icon.png',
    32,
    'B Titr',
  ),
  exarrosFont(
    'Exarros',
    'assets/color_icon.png',
    16,
    'Exarros',
  );

  final String fontFamily;
  final String iconPath;
  final double fontSize;
  final String name;
  const FontModel(this.fontFamily, this.iconPath, this.fontSize, this.name);
}
