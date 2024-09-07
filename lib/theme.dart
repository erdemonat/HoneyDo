import 'package:flutter/material.dart';

const Color customWhite = Color.fromARGB(255, 225, 230, 240);
const Color customBlack = Colors.black;
const Color customYellow = Color.fromARGB(255, 255, 208, 0);
const Color customRed = Color.fromARGB(255, 227, 86, 86);
const Color customLightGreen = Color.fromRGBO(159, 255, 163, 1);
const Color customGreen = Color(0xFF0DC9AB);

// ThemeData darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   scaffoldBackgroundColor: const Color.fromARGB(255, 28, 31, 38),
//   colorScheme: const ColorScheme.dark(
//     surface: Color.fromARGB(255, 20, 22, 26),
//     primary: Color.fromARGB(255, 40, 45, 60),
//     onPrimary: Color.fromARGB(255, 54, 63, 90),
//     inversePrimary: Color.fromARGB(255, 159, 172, 198),
//     secondary: Color.fromARGB(255, 40, 45, 60),
//     onSurface: Color.fromARGB(255, 52, 62, 93),
//     tertiary: Color.fromARGB(255, 159, 172, 198),
//   ),
//   textTheme: const TextTheme(
//     displayLarge: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//     displayMedium: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//     displaySmall: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//     headlineLarge: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//     headlineMedium: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//     headlineSmall: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//     labelLarge: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//     labelMedium: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//     labelSmall: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//     titleLarge: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//     titleMedium: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//     titleSmall: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//     bodyLarge: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//     bodyMedium: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//     bodySmall: TextStyle(color: Color.fromARGB(255, 159, 172, 198)),
//   ),
//   textSelectionTheme: const TextSelectionThemeData(
//     selectionColor: Color.fromARGB(60, 159, 172, 198),
//     cursorColor: Color.fromARGB(255, 159, 172, 198),
//   ),
//   iconButtonTheme: const IconButtonThemeData(
//     style: ButtonStyle(
//       iconColor: WidgetStatePropertyAll(
//         Color.fromARGB(255, 159, 172, 198),
//       ),
//     ),
//   ),
// );

// ThemeData lightTheme = ThemeData(
//   brightness: Brightness.light,
//   scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245),
//   colorScheme: const ColorScheme.light(
//     surface: Color.fromARGB(255, 255, 255, 255),
//     primary: Color.fromARGB(255, 100, 120, 150),
//     onPrimary: Color.fromARGB(255, 54, 63, 90),
//     inversePrimary: Color.fromARGB(255, 40, 45, 60),
//     secondary: Color.fromARGB(255, 100, 120, 150),
//     onSurface: Color.fromARGB(255, 20, 22, 26),
//     tertiary: Color.fromARGB(255, 40, 45, 60),
//   ),
//   textTheme: const TextTheme(
//     displayLarge: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//     displayMedium: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//     displaySmall: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//     headlineLarge: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//     headlineMedium: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//     headlineSmall: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//     labelLarge: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//     labelMedium: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//     labelSmall: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//     titleLarge: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//     titleMedium: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//     titleSmall: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//     bodyLarge: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//     bodyMedium: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//     bodySmall: TextStyle(color: Color.fromARGB(255, 54, 63, 90)),
//   ),
//   textSelectionTheme: const TextSelectionThemeData(
//     selectionColor: Color.fromARGB(60, 54, 63, 90),
//     cursorColor: Color.fromARGB(255, 54, 63, 90),
//   ),
//   iconButtonTheme: const IconButtonThemeData(
//     style: ButtonStyle(
//       iconColor: WidgetStatePropertyAll(
//         Color.fromARGB(255, 54, 63, 90),
//       ),
//     ),
//   ),
// );

// Theme 1
ThemeData darkTheme1 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF2F3C7E),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF202A50),
    primary: Color(0xFF2F3C7E),
    onPrimary: Color(0xFFFBEAEB),
    inversePrimary: Color(0xFF4A5D9E),
    secondary: Color(0xFF4A5D9E),
    onSurface: Color(0xFFFBEAEB),
    tertiary: Color(0xFF89ABE3),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFFFBEAEB)),
    displayMedium: TextStyle(color: Color(0xFFFBEAEB)),
  ),
);

ThemeData lightTheme1 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFFBEAEB),
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFFFFFFF),
    primary: Color(0xFF2F3C7E),
    onPrimary: Color(0xFFFBEAEB),
    inversePrimary: Color(0xFF2F3C7E),
    secondary: Color(0xFF89ABE3),
    onSurface: Color(0xFF202A50),
    tertiary: Color(0xFF4A5D9E),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF2F3C7E)),
    displayMedium: TextStyle(color: Color(0xFF2F3C7E)),
  ),
);

// Theme 2
ThemeData darkTheme2 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF89ABE3),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF61759B),
    primary: Color(0xFF89ABE3),
    onPrimary: Color(0xFFEA738D),
    inversePrimary: Color(0xFF5C789D),
    secondary: Color(0xFF5C789D),
    onSurface: Color(0xFFEA738D),
    tertiary: Color(0xFFEA738D),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFFEA738D)),
    displayMedium: TextStyle(color: Color(0xFFEA738D)),
  ),
);

ThemeData lightTheme2 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFEA738D),
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFFFFFFF),
    primary: Color(0xFF89ABE3),
    onPrimary: Color(0xFFEA738D),
    inversePrimary: Color(0xFF89ABE3),
    secondary: Color(0xFF5C789D),
    onSurface: Color(0xFF61759B),
    tertiary: Color(0xFF5C789D),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF89ABE3)),
    displayMedium: TextStyle(color: Color(0xFF89ABE3)),
  ),
);

// Theme 3
ThemeData darkTheme3 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFFCC313D),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF8F202C),
    primary: Color(0xFFCC313D),
    onPrimary: Color(0xFFF7C5CC),
    inversePrimary: Color(0xFFAA4452),
    secondary: Color(0xFFAA4452),
    onSurface: Color(0xFFF7C5CC),
    tertiary: Color(0xFFF7C5CC),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFFF7C5CC)),
    displayMedium: TextStyle(color: Color(0xFFF7C5CC)),
  ),
);

ThemeData lightTheme3 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF7C5CC),
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFFFFFFF),
    primary: Color(0xFFCC313D),
    onPrimary: Color(0xFFF7C5CC),
    inversePrimary: Color(0xFFCC313D),
    secondary: Color(0xFFAA4452),
    onSurface: Color(0xFF8F202C),
    tertiary: Color(0xFFAA4452),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFFCC313D)),
    displayMedium: TextStyle(color: Color(0xFFCC313D)),
  ),
);

// Theme 4
ThemeData darkTheme4 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF2C5F2D),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF224723),
    primary: Color(0xFF2C5F2D),
    onPrimary: Color(0xFF97BC62),
    inversePrimary: Color(0xFF3E7241),
    secondary: Color(0xFF3E7241),
    onSurface: Color(0xFF97BC62),
    tertiary: Color(0xFF97BC62),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF97BC62)),
    displayMedium: TextStyle(color: Color(0xFF97BC62)),
  ),
);

ThemeData lightTheme4 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFF97BC62),
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFFFFFFF),
    primary: Color(0xFF2C5F2D),
    onPrimary: Color(0xFF97BC62),
    inversePrimary: Color(0xFF2C5F2D),
    secondary: Color(0xFF3E7241),
    onSurface: Color(0xFF224723),
    tertiary: Color(0xFF3E7241),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF2C5F2D)),
    displayMedium: TextStyle(color: Color(0xFF2C5F2D)),
  ),
);

// Theme 5
ThemeData darkTheme5 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF735DA5),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF5A4B83),
    primary: Color(0xFF735DA5),
    onPrimary: Color(0xFFD3C5E5),
    inversePrimary: Color(0xFF8569BD),
    secondary: Color(0xFF8569BD),
    onSurface: Color(0xFFD3C5E5),
    tertiary: Color(0xFFD3C5E5),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFFD3C5E5)),
    displayMedium: TextStyle(color: Color(0xFFD3C5E5)),
  ),
);

ThemeData lightTheme5 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFD3C5E5),
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFFFFFFF),
    primary: Color(0xFF735DA5),
    onPrimary: Color(0xFFD3C5E5),
    inversePrimary: Color(0xFF735DA5),
    secondary: Color(0xFF8569BD),
    onSurface: Color(0xFF5A4B83),
    tertiary: Color(0xFF8569BD),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF735DA5)),
    displayMedium: TextStyle(color: Color(0xFF735DA5)),
  ),
);

// Theme 6
ThemeData darkTheme6 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFFC4DFE6),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF88A8B1),
    primary: Color(0xFFC4DFE6),
    onPrimary: Color(0xFF66A5AD),
    inversePrimary: Color(0xFF96C1CA),
    secondary: Color(0xFF96C1CA),
    onSurface: Color(0xFF66A5AD),
    tertiary: Color(0xFF66A5AD),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF66A5AD)),
    displayMedium: TextStyle(color: Color(0xFF66A5AD)),
  ),
);

ThemeData lightTheme6 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFF66A5AD),
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFFFFFFF),
    primary: Color(0xFFC4DFE6),
    onPrimary: Color(0xFF66A5AD),
    inversePrimary: Color(0xFFC4DFE6),
    secondary: Color(0xFF96C1CA),
    onSurface: Color(0xFF88A8B1),
    tertiary: Color(0xFF96C1CA),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFFC4DFE6)),
    displayMedium: TextStyle(color: Color(0xFFC4DFE6)),
  ),
);
