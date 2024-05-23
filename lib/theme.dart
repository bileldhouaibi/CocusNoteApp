import 'package:flutter/material.dart';

const ColorScheme colorScheme = ColorScheme.light(
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
    black: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
      displayMedium: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
    ),
    white: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      displayMedium: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
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
    padding: const EdgeInsets.all(8),
    labelStyle: TextStyle(color: colorScheme.onSecondary),
    secondaryLabelStyle: TextStyle(color: colorScheme.onPrimary),
    brightness: Brightness.light,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: colorScheme.onPrimary,
      backgroundColor: colorScheme.primary,
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
