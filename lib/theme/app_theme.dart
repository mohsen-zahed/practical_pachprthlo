import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';

class AppTheme {
  static ThemeData lightTheme({Color? primaryColor, Color? secondaryColor}) {
    return ThemeData(
      primaryColor: primaryColor ?? kPrimaryColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: kWhiteColor,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        foregroundColor: kWhiteColor,
        backgroundColor: primaryColor ?? kPrimaryColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: kWhiteColor,
        backgroundColor: secondaryColor ?? kSecondaryColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 10,
        backgroundColor: kRedColor,
        selectedItemColor: primaryColor ?? kPrimaryColor,
        unselectedItemColor: kGreyColorShade800,
      ),
      cardTheme: CardTheme(
        color: kWhiteColor,
        elevation: 5,
        shadowColor: kBlackColorOp5,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: primaryColor ?? kPrimaryColor,
        elevation: 10,
        showCloseIcon: true,
        contentTextStyle: const TextStyle(color: kWhiteColor),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: primaryColor?.withOpacity(0.2) ?? kPrimaryColor.withOpacity(0.2),
        iconColor: primaryColor ?? kPrimaryColor,
      ),
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: kWhiteColor),
      expansionTileTheme: const ExpansionTileThemeData(
        collapsedBackgroundColor: kWhiteColor,
        backgroundColor: kWhiteColor,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.all(kWhiteColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            foregroundColor: const WidgetStatePropertyAll(kWhiteColor),
            backgroundColor: WidgetStatePropertyAll(primaryColor ?? kPrimaryColor),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )),
      ),
      textTheme: lightTextTheme,
    );
  }

  static ThemeData darkTheme({Color? primaryColor, Color? secondaryColor}) {
    return ThemeData(
      primaryColor: primaryColor ?? kPrimaryColor,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: kGreyColorShade900,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        foregroundColor: kWhiteColor,
        backgroundColor: primaryColor?.withOpacity(0.5) ?? kPrimaryColor.withOpacity(0.5),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: kWhiteColor,
        backgroundColor: secondaryColor ?? kSecondaryColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor ?? kPrimaryColor,
        backgroundColor: kGreyColorShade900,
        unselectedItemColor: kWhiteColor60,
      ),
      cardTheme: CardTheme(
        color: kGreyColorShade800,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: kGreyColorShade900,
        showCloseIcon: true,
        contentTextStyle: const TextStyle(color: kWhiteColor),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: kGreyColorShade800,
        textColor: kWhiteColor,
        iconColor: primaryColor ?? kPrimaryColor,
      ),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: kGreyColorShade900),
      expansionTileTheme: ExpansionTileThemeData(
        collapsedBackgroundColor: kGreyColorShade800,
        backgroundColor: kGreyColorShade800,
      ),
      textTheme: darkTextTheme,
    );
  }

  static TextTheme darkTextTheme = const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
  );

  static TextTheme lightTextTheme = const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    ),
    displayMedium: TextStyle(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    displaySmall: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  );
}
