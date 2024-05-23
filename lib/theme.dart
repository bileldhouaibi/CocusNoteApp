import 'package:flutter/material.dart';

final ColorScheme colorScheme = ColorScheme.light(
  primary: Color(0xFFFFA726), // Orange color for primary actions
  onPrimary: Colors.white,
  secondary: Color(0xFFF5F5F5), // Light grey for backgrounds
  onSecondary: Colors.black,
  surface: Colors.white,
  onSurface: Colors.black,
  background: Color(0xFFFFFFFF),
  onBackground: Colors.black,
);

final ThemeData themeData = ThemeData(
  useMaterial3: true,
  colorScheme: colorScheme,
  typography: Typography.material2021(
    black: TextTheme(
      headline1: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
      headline2: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      bodyText1: TextStyle(fontSize: 16, color: Colors.black),
      bodyText2: TextStyle(fontSize: 14, color: Colors.black54),
    ),
    white: TextTheme(
      headline1: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      headline2: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      bodyText1: TextStyle(fontSize: 16, color: Colors.white),
      bodyText2: TextStyle(fontSize: 14, color: Colors.white70),
    ),
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    buttonColor: colorScheme.primary,
    textTheme: ButtonTextTheme.primary,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: colorScheme.secondary,
    disabledColor: Colors.grey,
    selectedColor: colorScheme.primary,
    secondarySelectedColor: colorScheme.primary.withOpacity(0.48),
    padding: EdgeInsets.all(8),
    labelStyle: TextStyle(color: colorScheme.onSecondary),
    secondaryLabelStyle: TextStyle(color: colorScheme.onPrimary),
    brightness: Brightness.light,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: colorScheme.primary,
      onPrimary: colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: colorScheme.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: colorScheme.primary),
    ),
  ),
);
