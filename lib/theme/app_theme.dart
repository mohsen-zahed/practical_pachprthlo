import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: kWhiteColor,
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        foregroundColor: kWhiteColor,
        backgroundColor: kPurpleColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: kWhiteColor,
        backgroundColor: kPurpleColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 10,
        backgroundColor: kRedColor,
        selectedItemColor: kPurpleColor,
        unselectedItemColor: kGreyColorShade800,
      ),
      cardTheme: CardTheme(
        color: kWhiteColor,
        elevation: 5,
        shadowColor: kBlackColorOp5,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: kWhiteColor,
        elevation: 10,
        showCloseIcon: true,
        contentTextStyle: TextStyle(color: kBlackColor),
      ),
      listTileTheme: ListTileThemeData(tileColor: kGreyColorShade300),
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
      textTheme: lightTextTheme,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primarySwatch: Colors.indigo,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: kGreyColorShade900,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        foregroundColor: kWhiteColor,
        backgroundColor: kPurpleColor.withOpacity(0.5),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: kWhiteColor,
        backgroundColor: kPurpleColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: kPurpleColor,
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
      ),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: kGreyColorShade900),
      expansionTileTheme: ExpansionTileThemeData(
        collapsedBackgroundColor: kGreyColorShade800,
        backgroundColor: kGreyColorShade800,
      ),
      textTheme: darkTextTheme,
    );
  }

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
}
