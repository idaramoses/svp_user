import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_constants.dart';

class Themes {
  static ThemeData lightTheme = ThemeData(
      fontFamily: GoogleFonts.nunito().fontFamily,
      primaryColor: const Color(0xFFe4ab2e),
      primarySwatch: Colors.yellow,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          titleTextStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey.shade50,
          elevation: 0),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        hintStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
      cardColor: Colors.grey.shade200,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: Colors.red),
      iconTheme: const IconThemeData(color: Colors.black), // Set icon theme color to white

      textTheme: TextTheme(
          headline1: const TextStyle(
              letterSpacing: -1.5,
              fontSize: 48,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          headline2: const TextStyle(
              letterSpacing: -1.0,
              fontSize: 40,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          headline3: const TextStyle(
              letterSpacing: -1.0,
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          headline4: const TextStyle(
              letterSpacing: -1.0,
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w600),
          headline5: const TextStyle(
              letterSpacing: -1.0,
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500),
          headline6: const TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
          subtitle1: const TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
          subtitle2: const TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          bodyText1: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          bodyText2: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          button: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
          caption: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 12,
              fontWeight: FontWeight.w400),
          overline: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.5)));

  static ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.nunito().fontFamily,
    primaryColor:   const Color(0xFFe4ab2e),
    primarySwatch: Colors.yellow,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorConstants.gray900,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorConstants.gray900,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    bottomAppBarColor: ColorConstants.gray800,
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        hintStyle: const TextStyle(
          fontSize: 14,
        )),
    cardColor: ColorConstants.gray700,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.white),
    textTheme: TextTheme(
        headline1: TextStyle(
            letterSpacing: -1.5,
            fontSize: 48,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold),
        headline2: TextStyle(
            letterSpacing: -1.0,
            fontSize: 40,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold),
        headline3: TextStyle(
            letterSpacing: -1.0,
            fontSize: 32,
            color: Colors.grey.shade50,
            fontWeight: FontWeight.bold),
        headline4: TextStyle(
            letterSpacing: -1.0,
            color: Colors.grey.shade50,
            fontSize: 28,
            fontWeight: FontWeight.w600),
        headline5: TextStyle(
            letterSpacing: -1.0,
            color: Colors.grey.shade50,
            fontSize: 24,
            fontWeight: FontWeight.w500),
        headline6: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 22,
            fontWeight: FontWeight.w500),
        subtitle1: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 17,
            fontWeight: FontWeight.w500),
        subtitle2: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 14,
            fontWeight: FontWeight.w500),
        bodyText1: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        bodyText2: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        button: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
        caption: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 12,
            fontWeight: FontWeight.w500),
        overline: TextStyle(
            color: Colors.grey.shade50,
            fontSize: 10,
            fontWeight: FontWeight.w400)),
            iconTheme: const IconThemeData(color: Colors.white), // Set icon theme color to white

  );

  static ThemeData getColorsTheme(BuildContext context) {
    return Theme.of(context);
  }

  static Color getTextColor(BuildContext context) {
    return getColorsTheme(context).textTheme.headline6!.color!;
  }

  static Color? getHintTextColor(BuildContext context) {
    return getColorsTheme(context).textTheme.subtitle1!.color;
  }

  static Color getScaffoldColor(BuildContext context) {
    return getColorsTheme(context).scaffoldBackgroundColor;
  }

  static Color getCardColor(BuildContext context) {
    return getColorsTheme(context).cardColor;
  }

  static Color getDividerColor(BuildContext context) {
    return getColorsTheme(context).dividerColor;
  }

  static Color getPrimaryColor(BuildContext context) {
    return getColorsTheme(context).primaryColor;
  }

  static Color getShadowColor(BuildContext context) {
    return getColorsTheme(context).shadowColor;
  }
}
