import 'package:flutter/material.dart';

const Color customScaffold = Color.fromARGB(255, 225, 230, 240);
const Color customSurface = Colors.black;
const Color customePrimary = Color.fromARGB(255, 255, 208, 0);
const Color customOnPrimary = Color.fromARGB(255, 227, 86, 86);
const Color customInversePrimary = Color.fromRGBO(159, 255, 163, 1);
const Color customSecondary = Color(0xFF0DC9AB);
const Color customOnSecondary = Color(0xFF0DC9AB);
const Color customTertitary = Color(0xFF0DC9AB);
const Color customFontColors = Color(0xFF0DC9AB);
const Color customIconColors = Color(0xFF0DC9AB);

ThemeData darkTheme1 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(255, 28, 31, 38),
  colorScheme: const ColorScheme.dark(
    surface: Color.fromARGB(255, 20, 22, 26),
    primary: Color.fromARGB(255, 40, 45, 60),
    onPrimary: Color.fromARGB(255, 159, 172, 198),
    inversePrimary: Color.fromARGB(255, 159, 172, 198),
    secondary: Color.fromARGB(255, 40, 45, 60),
    onSurface: Color.fromARGB(255, 159, 172, 198),
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
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 159, 172, 198),
      ),
    ),
  ),
);

ThemeData lightTheme1 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 201, 220, 246),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 185, 208, 242),
    primary: Color.fromARGB(255, 151, 179, 220),
    onPrimary: Color.fromARGB(255, 209, 226, 251),
    inversePrimary: Color.fromARGB(255, 40, 45, 60),
    secondary: Color.fromARGB(255, 147, 173, 212),
    onSurface: Color.fromARGB(255, 20, 22, 26),
    tertiary: Color.fromARGB(255, 40, 45, 60),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 40, 45, 60)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 20, 22, 26),
    cursorColor: Color.fromARGB(255, 20, 22, 26),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 20, 22, 26),
      ),
    ),
  ),
);

ThemeData darkTheme2 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF343A40),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF212529),
    primary: Color(0xFF495057),
    onPrimary: Color(0xFFADB5BD),
    inversePrimary: Color(0xFFFFE6C7),
    secondary: Color.fromARGB(255, 233, 131, 67),
    onSurface: Color(0xFFFFA559),
    tertiary: Color(0xFFFFE6C7),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 255, 244, 231)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 255, 230, 199),
    cursorColor: Color(0xFFFFE6C7),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color(0xFFFFA559),
      ),
    ),
  ),
);

ThemeData lightTheme2 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 247, 240),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 248, 227, 211),
    primary: Color.fromARGB(255, 237, 190, 168),
    onPrimary: Color.fromARGB(255, 255, 247, 240),
    inversePrimary: Color.fromARGB(255, 74, 40, 16),
    secondary: Color.fromARGB(255, 255, 161, 114),
    onSurface: Color.fromARGB(255, 90, 51, 27),
    tertiary: Color.fromARGB(255, 74, 40, 16),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 74, 40, 16)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 74, 40, 16),
    cursorColor: Color.fromARGB(255, 74, 40, 16),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 90, 51, 27),
      ),
    ),
  ),
);

ThemeData darkTheme3 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF343A40),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF212529),
    primary: Color(0xFF495057),
    onPrimary: Color(0xFFADB5BD),
    inversePrimary: Color(0xFFF8F9FA),
    secondary: Color(0xFF495057),
    onSurface: Color(0xFFDEE2E6),
    tertiary: Color(0xFFF8F9FA),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFFF8F9FA)),
    displayMedium: TextStyle(color: Color(0xFFF8F9FA)),
    displaySmall: TextStyle(color: Color(0xFFF8F9FA)),
    headlineLarge: TextStyle(color: Color(0xFFF8F9FA)),
    headlineMedium: TextStyle(color: Color(0xFFF8F9FA)),
    headlineSmall: TextStyle(color: Color(0xFFF8F9FA)),
    labelLarge: TextStyle(color: Color(0xFFF8F9FA)),
    labelMedium: TextStyle(color: Color(0xFFF8F9FA)),
    labelSmall: TextStyle(color: Color(0xFFF8F9FA)),
    titleLarge: TextStyle(color: Color(0xFFF8F9FA)),
    titleMedium: TextStyle(color: Color(0xFFF8F9FA)),
    titleSmall: TextStyle(color: Color(0xFFF8F9FA)),
    bodyLarge: TextStyle(color: Color(0xFFF8F9FA)),
    bodyMedium: TextStyle(color: Color(0xFFF8F9FA)),
    bodySmall: TextStyle(color: Color(0xFFF8F9FA)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 248, 249, 250),
    cursorColor: Color(0xFFF8F9FA),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color(0xFFDEE2E6),
      ),
    ),
  ),
);

ThemeData lightTheme3 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFE9ECEF),
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFF8F9FA),
    primary: Color(0xFFADB5BD),
    onPrimary: Color(0xFFE9ECEF),
    inversePrimary: Color(0xFF212529),
    secondary: Color(0xFFADB5BD),
    onSurface: Color(0xFF495057),
    tertiary: Color(0xFF212529),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF212529)),
    displayMedium: TextStyle(color: Color(0xFF212529)),
    displaySmall: TextStyle(color: Color(0xFF212529)),
    headlineLarge: TextStyle(color: Color(0xFF212529)),
    headlineMedium: TextStyle(color: Color(0xFF212529)),
    headlineSmall: TextStyle(color: Color(0xFF212529)),
    labelLarge: TextStyle(color: Color(0xFF212529)),
    labelMedium: TextStyle(color: Color(0xFF212529)),
    labelSmall: TextStyle(color: Color(0xFF212529)),
    titleLarge: TextStyle(color: Color(0xFF212529)),
    titleMedium: TextStyle(color: Color(0xFF212529)),
    titleSmall: TextStyle(color: Color(0xFF212529)),
    bodyLarge: TextStyle(color: Color(0xFF212529)),
    bodyMedium: TextStyle(color: Color(0xFF212529)),
    bodySmall: TextStyle(color: Color(0xFF212529)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 33, 37, 41),
    cursorColor: Color(0xFF212529),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color(0xFF212529),
      ),
    ),
  ),
);

ThemeData darkTheme4 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF343A40),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF212529),
    primary: Color(0xFF495057),
    onPrimary: Color(0xFFADB5BD),
    inversePrimary: Color.fromARGB(255, 213, 255, 231),
    secondary: Color.fromARGB(255, 64, 202, 96),
    onSurface: Color.fromARGB(255, 143, 246, 167),
    tertiary: Color.fromARGB(255, 213, 255, 231),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 213, 255, 231)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 213, 255, 231),
    cursorColor: Color.fromARGB(255, 213, 255, 231),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 143, 246, 167),
      ),
    ),
  ),
);

ThemeData lightTheme4 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 240, 255, 240),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 215, 248, 211),
    primary: Color.fromARGB(255, 189, 235, 186),
    onPrimary: Color.fromARGB(255, 241, 255, 240),
    inversePrimary: Color.fromARGB(255, 37, 74, 39),
    secondary: Color.fromARGB(255, 129, 205, 131),
    onSurface: Color.fromARGB(255, 53, 84, 53),
    tertiary: Color.fromARGB(255, 37, 74, 39),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 37, 74, 39)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 37, 74, 39),
    cursorColor: Color.fromARGB(255, 37, 74, 39),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 53, 84, 53),
      ),
    ),
  ),
);

ThemeData darkTheme5 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF343A40),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF212529),
    primary: Color(0xFF495057),
    onPrimary: Color(0xFFADB5BD),
    inversePrimary: Color.fromARGB(255, 255, 199, 199),
    secondary: Color.fromARGB(255, 217, 73, 73),
    onSurface: Color.fromARGB(255, 251, 125, 125),
    tertiary: Color.fromARGB(255, 255, 199, 199),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 255, 199, 199)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(59, 255, 199, 199),
    cursorColor: Color.fromARGB(255, 255, 199, 199),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 251, 125, 125),
      ),
    ),
  ),
);

ThemeData lightTheme5 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 240, 240),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 248, 211, 211),
    primary: Color.fromARGB(255, 225, 150, 150),
    onPrimary: Color.fromARGB(255, 255, 240, 240),
    inversePrimary: Color.fromARGB(255, 126, 47, 47),
    secondary: Color.fromARGB(255, 214, 124, 124),
    onSurface: Color.fromARGB(255, 112, 58, 58),
    tertiary: Color.fromARGB(255, 126, 47, 47),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 126, 47, 47)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(59, 126, 47, 47),
    cursorColor: Color.fromARGB(255, 126, 47, 47),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 112, 58, 58),
      ),
    ),
  ),
);

ThemeData darkTheme6 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF343A40),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF212529),
    primary: Color(0xFF495057),
    onPrimary: Color(0xFFADB5BD),
    inversePrimary: Color.fromARGB(255, 217, 204, 235),
    secondary: Color.fromARGB(255, 158, 123, 242),
    onSurface: Color.fromARGB(255, 175, 155, 222),
    tertiary: Color.fromARGB(255, 217, 204, 235),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 217, 204, 235)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 217, 204, 235),
    cursorColor: Color.fromARGB(255, 217, 204, 235),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 175, 155, 222),
      ),
    ),
  ),
);

ThemeData lightTheme6 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 238, 230, 247),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 217, 204, 235),
    primary: Color.fromARGB(255, 175, 155, 222),
    onPrimary: Color.fromARGB(255, 238, 230, 247),
    inversePrimary: Color.fromARGB(255, 83, 66, 124),
    secondary: Color.fromARGB(255, 187, 158, 255),
    onSurface: Color.fromARGB(255, 91, 78, 119),
    tertiary: Color.fromARGB(255, 83, 66, 124),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 83, 66, 124)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 115, 93, 165),
    cursorColor: Color.fromARGB(255, 83, 66, 124),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 91, 78, 119),
      ),
    ),
  ),
);

ThemeData darkTheme7 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF343A40),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF212529),
    primary: Color(0xFF495057),
    onPrimary: Color(0xFFADB5BD),
    inversePrimary: Color.fromARGB(255, 199, 242, 255),
    secondary: Color.fromARGB(255, 70, 144, 196),
    onSurface: Color.fromARGB(255, 117, 190, 224),
    tertiary: Color.fromARGB(255, 199, 242, 255),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 199, 242, 255)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 199, 242, 255),
    cursorColor: Color.fromARGB(255, 199, 242, 255),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 117, 190, 224),
      ),
    ),
  ),
);

ThemeData lightTheme7 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 240, 250, 255),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 211, 234, 248),
    primary: Color.fromARGB(255, 163, 211, 237),
    onPrimary: Color.fromARGB(255, 240, 249, 255),
    inversePrimary: Color.fromARGB(255, 47, 92, 126),
    secondary: Color.fromARGB(255, 138, 195, 229),
    onSurface: Color.fromARGB(255, 58, 88, 112),
    tertiary: Color.fromARGB(255, 47, 92, 126),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 47, 92, 126)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 47, 92, 126),
    cursorColor: Color.fromARGB(255, 47, 92, 126),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 58, 88, 112),
      ),
    ),
  ),
);

ThemeData darkTheme8 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF2F3C7E),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF1b234b),
    primary: Color.fromARGB(255, 65, 78, 143),
    onPrimary: Color(0xFFFBEAEB),
    inversePrimary: Color(0xFFFBEAEB),
    secondary: Color(0xFF4b60ca),
    onSurface: Color(0xFF8E9DE7),
    tertiary: Color(0xFFFBEAEB),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFFFBEAEB)),
    displayMedium: TextStyle(color: Color(0xFFFBEAEB)),
    displaySmall: TextStyle(color: Color(0xFFFBEAEB)),
    headlineLarge: TextStyle(color: Color(0xFFFBEAEB)),
    headlineMedium: TextStyle(color: Color(0xFFFBEAEB)),
    headlineSmall: TextStyle(color: Color(0xFFFBEAEB)),
    labelLarge: TextStyle(color: Color(0xFFFBEAEB)),
    labelMedium: TextStyle(color: Color(0xFFFBEAEB)),
    labelSmall: TextStyle(color: Color(0xFFFBEAEB)),
    titleLarge: TextStyle(color: Color(0xFFFBEAEB)),
    titleMedium: TextStyle(color: Color(0xFFFBEAEB)),
    titleSmall: TextStyle(color: Color(0xFFFBEAEB)),
    bodyLarge: TextStyle(color: Color(0xFFFBEAEB)),
    bodyMedium: TextStyle(color: Color(0xFFFBEAEB)),
    bodySmall: TextStyle(color: Color(0xFFFBEAEB)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 251, 234, 235),
    cursorColor: Color(0xFFFBEAEB),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color(0xFF8E9DE7),
      ),
    ),
  ),
);

ThemeData lightTheme8 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 240, 243, 255),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 211, 217, 248),
    primary: Color.fromARGB(255, 150, 162, 225),
    onPrimary: Color.fromARGB(255, 240, 243, 255),
    inversePrimary: Color(0xFF2F3C7E),
    secondary: Color.fromARGB(255, 124, 139, 214),
    onSurface: Color.fromARGB(255, 58, 67, 112),
    tertiary: Color(0xFF2F3C7E),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF2F3C7E)),
    displayMedium: TextStyle(color: Color(0xFF2F3C7E)),
    displaySmall: TextStyle(color: Color(0xFF2F3C7E)),
    headlineLarge: TextStyle(color: Color(0xFF2F3C7E)),
    headlineMedium: TextStyle(color: Color(0xFF2F3C7E)),
    headlineSmall: TextStyle(color: Color(0xFF2F3C7E)),
    labelLarge: TextStyle(color: Color(0xFF2F3C7E)),
    labelMedium: TextStyle(color: Color(0xFF2F3C7E)),
    labelSmall: TextStyle(color: Color(0xFF2F3C7E)),
    titleLarge: TextStyle(color: Color(0xFF2F3C7E)),
    titleMedium: TextStyle(color: Color(0xFF2F3C7E)),
    titleSmall: TextStyle(color: Color(0xFF2F3C7E)),
    bodyLarge: TextStyle(color: Color(0xFF2F3C7E)),
    bodyMedium: TextStyle(color: Color(0xFF2F3C7E)),
    bodySmall: TextStyle(color: Color(0xFF2F3C7E)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 47, 60, 126),
    cursorColor: Color(0xFF2F3C7E),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 58, 67, 112),
      ),
    ),
  ),
);

ThemeData darkTheme9 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF343A40),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF212529),
    primary: Color(0xFF495057),
    onPrimary: Color(0xFFADB5BD),
    inversePrimary: Color.fromARGB(255, 244, 210, 218),
    secondary: Color.fromARGB(255, 255, 142, 166),
    onSurface: Color.fromARGB(255, 228, 138, 158),
    tertiary: Color.fromARGB(255, 244, 210, 218),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 244, 210, 218)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 244, 210, 218),
    cursorColor: Color.fromARGB(255, 244, 210, 218),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 228, 138, 158),
      ),
    ),
  ),
);

ThemeData lightTheme9 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 237, 242),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 252, 212, 221),
    primary: Color.fromARGB(255, 246, 180, 195),
    onPrimary: Color.fromARGB(255, 252, 230, 235),
    inversePrimary: Color.fromARGB(255, 154, 28, 55),
    secondary: Color.fromARGB(255, 247, 179, 194),
    onSurface: Color.fromARGB(255, 177, 38, 68),
    tertiary: Color.fromARGB(255, 154, 28, 55),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 154, 28, 55)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 154, 28, 55),
    cursorColor: Color.fromARGB(255, 154, 28, 55),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 177, 38, 68),
      ),
    ),
  ),
);
