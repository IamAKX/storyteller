import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

const double defaultPadding = 20;
const double homePageUserIconSize = 40;

ThemeData globalTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: false,
    scaffoldBackgroundColor: background,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      background: background, // Your accent color
    ),
    primaryColor: themeBlue,
    textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme).apply(
      bodyColor: textColor,
      displayColor: textColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: textColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: false,
      filled: true,
      fillColor: inputFillColor,
      hintStyle:
          Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: themeBlue,
          width: 1,
          // style: BorderStyle.none,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: themeBlue)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: themeBlue),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: themeBlue,
        side: const BorderSide(color: themeBlue),
      ),
    ),
  );
}
