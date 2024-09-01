import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(255, 28, 31, 38),
  colorScheme: const ColorScheme.dark(
    surface: Color.fromARGB(255, 20, 22, 26),
    primary: Color.fromARGB(255, 40, 45, 60),
    onPrimary: Color.fromARGB(255, 54, 63, 90),
    inversePrimary: Color.fromARGB(255, 159, 172, 198),
    secondary: Color.fromARGB(255, 40, 45, 60),
    onSurface: Color.fromARGB(255, 52, 62, 93),
    tertiary: Color.fromARGB(255, 159, 172, 198),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 159, 172, 198),
    cursorColor: Color.fromARGB(255, 159, 172, 198),
  ),
);

const Color customWhite = Colors.white;
const Color customBlack = Colors.black;
const Color customYellow = Color.fromARGB(255, 255, 208, 0);
const Color customRed = Color.fromARGB(255, 227, 86, 86);
const Color customLightGreen = Color.fromRGBO(159, 255, 163, 1);
const Color customGreen = Color(0xFF0DC9AB);
