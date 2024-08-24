import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(255, 28, 31, 38),
  colorScheme: const ColorScheme.dark(
    primary: Color.fromARGB(255, 40, 45, 60),
    onPrimary: Colors.black12,
    inversePrimary: Color.fromARGB(255, 159, 172, 198),
    secondary: Color(0xff282d3c),
    surface: Color.fromARGB(255, 20, 22, 26),
    onSurface: Color.fromARGB(255, 159, 172, 198),
    tertiary: Color.fromARGB(255, 159, 172, 198),
  ),
  cardTheme: CardTheme(
    elevation: 0,
    color: const Color(0xff4f4f4f),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
  ),
);
