import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';
import 'package:practical_pachprthlo/features/providers/color_provider.dart';

class ColorHelper {
  //* Don't know why throws constructor exception while setting constructor as private...
  // ColorHelper._();
  static void showColorPicker(BuildContext context) {
    MaterialColor? pickedColor;
    showDialog(
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.pickAColor),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: kPrimaryColor,
            onColorChanged: (Color newColor) {
              if (newColor is MaterialColor) {
                pickedColor = newColor;
                context.read<ColorProvider>().updatePrimaryColor(newColor);
              }
            },
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.applyColor),
            onPressed: () {
              if (pickedColor != null) {
                context.read<ColorProvider>().updatePrimaryColor(pickedColor!);
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      context: context,
    );
  }

  static MaterialColor createMaterialColor(Color color) {
    return MaterialColor(
      color.value,
      {
        50: color.withOpacity(0.1),
        100: color.withOpacity(0.2),
        200: color.withOpacity(0.3),
        300: color.withOpacity(0.4),
        400: color.withOpacity(0.5),
        500: color,
        600: color.withOpacity(0.7),
        700: color.withOpacity(0.8),
        800: color.withOpacity(0.9),
        900: color.withOpacity(1.0),
      },
    );
  }

  static String encodeMaterialColor(MaterialColor color) {
    //* Gets the primary color (shade 500) in hex string
    return color[500]!.value.toRadixString(16);
  }

  static MaterialColor decodeMaterialColor(String colorString) {
    //* Converts hex string to int and add alpha
    int colorValue = int.parse(colorString, radix: 16) + 0xFF000000;
    Color color = Color(colorValue);

    //* Create a MaterialColor object from the Color
    return createMaterialColor(color);
  }
}
