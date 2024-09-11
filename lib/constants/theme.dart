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
  scaffoldBackgroundColor: const Color.fromARGB(255, 191, 214, 247),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 164, 189, 227),
    primary: Color.fromARGB(255, 126, 149, 184),
    onPrimary: Color.fromARGB(255, 191, 214, 247),
    inversePrimary: Color.fromARGB(255, 40, 45, 60),
    secondary: Color.fromARGB(255, 120, 148, 191),
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
  scaffoldBackgroundColor: const Color.fromARGB(255, 250, 213, 190),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 255, 186, 144),
    primary: Color.fromARGB(255, 244, 132, 95),
    onPrimary: Color.fromARGB(255, 250, 213, 190),
    inversePrimary: Color.fromARGB(255, 138, 49, 44),
    secondary: Color.fromARGB(255, 242, 112, 89),
    onSurface: Color.fromARGB(255, 156, 61, 45),
    tertiary: Color.fromARGB(255, 138, 49, 44),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 138, 49, 44)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 138, 49, 44),
    cursorColor: Color.fromARGB(255, 138, 49, 44),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 156, 61, 45),
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
  scaffoldBackgroundColor: const Color.fromARGB(255, 66, 94, 77),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF31473A),
    primary: Color.fromARGB(255, 98, 129, 111),
    onPrimary: Color.fromARGB(255, 168, 212, 187),
    inversePrimary: Color(0xFFEDF4F2),
    secondary: Color.fromARGB(255, 142, 213, 172),
    onSurface: Color.fromARGB(255, 173, 235, 199),
    tertiary: Color(0xFFEDF4F2),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFFEDF4F2)),
    displayMedium: TextStyle(color: Color(0xFFEDF4F2)),
    displaySmall: TextStyle(color: Color(0xFFEDF4F2)),
    headlineLarge: TextStyle(color: Color(0xFFEDF4F2)),
    headlineMedium: TextStyle(color: Color(0xFFEDF4F2)),
    headlineSmall: TextStyle(color: Color(0xFFEDF4F2)),
    labelLarge: TextStyle(color: Color(0xFFEDF4F2)),
    labelMedium: TextStyle(color: Color(0xFFEDF4F2)),
    labelSmall: TextStyle(color: Color(0xFFEDF4F2)),
    titleLarge: TextStyle(color: Color(0xFFEDF4F2)),
    titleMedium: TextStyle(color: Color(0xFFEDF4F2)),
    titleSmall: TextStyle(color: Color(0xFFEDF4F2)),
    bodyLarge: TextStyle(color: Color(0xFFEDF4F2)),
    bodyMedium: TextStyle(color: Color(0xFFEDF4F2)),
    bodySmall: TextStyle(color: Color(0xFFEDF4F2)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 237, 244, 242),
    cursorColor: Color(0xFFEDF4F2),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 138, 179, 156),
      ),
    ),
  ),
);

ThemeData lightTheme4 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 189, 249, 213),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 213, 255, 231),
    primary: Color.fromARGB(255, 135, 184, 155),
    onPrimary: Color.fromARGB(255, 189, 249, 213),
    inversePrimary: Color(0xFF31473A),
    secondary: Color.fromARGB(255, 135, 184, 155),
    onSurface: Color.fromARGB(255, 82, 118, 98),
    tertiary: Color(0xFF31473A),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF31473A)),
    displayMedium: TextStyle(color: Color(0xFF31473A)),
    displaySmall: TextStyle(color: Color(0xFF31473A)),
    headlineLarge: TextStyle(color: Color(0xFF31473A)),
    headlineMedium: TextStyle(color: Color(0xFF31473A)),
    headlineSmall: TextStyle(color: Color(0xFF31473A)),
    labelLarge: TextStyle(color: Color(0xFF31473A)),
    labelMedium: TextStyle(color: Color(0xFF31473A)),
    labelSmall: TextStyle(color: Color(0xFF31473A)),
    titleLarge: TextStyle(color: Color(0xFF31473A)),
    titleMedium: TextStyle(color: Color(0xFF31473A)),
    titleSmall: TextStyle(color: Color(0xFF31473A)),
    bodyLarge: TextStyle(color: Color(0xFF31473A)),
    bodyMedium: TextStyle(color: Color(0xFF31473A)),
    bodySmall: TextStyle(color: Color(0xFF31473A)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 49, 71, 58),
    cursorColor: Color(0xFF31473A),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color(0xFF31473A),
      ),
    ),
  ),
);

ThemeData darkTheme5 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(255, 101, 163, 171),
  colorScheme: const ColorScheme.dark(
    surface: Color.fromARGB(255, 61, 112, 119),
    primary: Color.fromARGB(255, 79, 138, 146),
    onPrimary: Color.fromARGB(255, 153, 225, 235),
    inversePrimary: Color(0xFFC4DFE6),
    secondary: Color.fromARGB(255, 86, 208, 225),
    onSurface: Color.fromARGB(255, 143, 211, 220),
    tertiary: Color(0xFFC4DFE6),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFFC4DFE6)),
    displayMedium: TextStyle(color: Color(0xFFC4DFE6)),
    displaySmall: TextStyle(color: Color(0xFFC4DFE6)),
    headlineLarge: TextStyle(color: Color(0xFFC4DFE6)),
    headlineMedium: TextStyle(color: Color(0xFFC4DFE6)),
    headlineSmall: TextStyle(color: Color(0xFFC4DFE6)),
    labelLarge: TextStyle(color: Color(0xFFC4DFE6)),
    labelMedium: TextStyle(color: Color(0xFFC4DFE6)),
    labelSmall: TextStyle(color: Color(0xFFC4DFE6)),
    titleLarge: TextStyle(color: Color(0xFFC4DFE6)),
    titleMedium: TextStyle(color: Color(0xFFC4DFE6)),
    titleSmall: TextStyle(color: Color(0xFFC4DFE6)),
    bodyLarge: TextStyle(color: Color(0xFFC4DFE6)),
    bodyMedium: TextStyle(color: Color(0xFFC4DFE6)),
    bodySmall: TextStyle(color: Color(0xFFC4DFE6)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 196, 223, 230),
    cursorColor: Color(0xFFC4DFE6),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 143, 211, 220),
      ),
    ),
  ),
);

ThemeData lightTheme5 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFC4DFE6),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 157, 204, 212),
    primary: Color.fromARGB(255, 122, 166, 174),
    onPrimary: Color(0xFFC4DFE6),
    inversePrimary: Color.fromARGB(255, 34, 61, 64),
    secondary: Color.fromARGB(255, 98, 171, 184),
    onSurface: Color.fromARGB(255, 60, 107, 115),
    tertiary: Color.fromARGB(255, 34, 61, 64),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Color.fromARGB(255, 34, 61, 64),
    ),
    displayMedium: TextStyle(color: Color.fromARGB(255, 34, 61, 64)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 34, 61, 64)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 34, 61, 64)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 34, 61, 64)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 34, 61, 64)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 34, 61, 64)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 34, 61, 64)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 34, 61, 64)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 34, 61, 64)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 34, 61, 64)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 34, 61, 64)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 34, 61, 64)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 34, 61, 64)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 34, 61, 64)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 34, 61, 64),
    cursorColor: Color.fromARGB(255, 34, 61, 64),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 60, 107, 115),
      ),
    ),
  ),
);

ThemeData darkTheme6 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(255, 148, 123, 205),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF735DA5),
    primary: Color.fromARGB(255, 159, 135, 217),
    onPrimary: Color.fromARGB(255, 253, 250, 255),
    inversePrimary: Color.fromARGB(255, 253, 250, 255),
    secondary: Color.fromARGB(255, 187, 157, 255),
    onSurface: Color.fromARGB(255, 201, 185, 237),
    tertiary: Color.fromARGB(255, 253, 250, 255),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 253, 250, 255)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 253, 250, 255),
    cursorColor: Color.fromARGB(255, 253, 250, 255),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 201, 185, 237),
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
    secondary: Color.fromARGB(255, 150, 119, 220),
    onSurface: Color.fromARGB(255, 125, 108, 164),
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
        Color.fromARGB(255, 125, 108, 164),
      ),
    ),
  ),
);

ThemeData darkTheme7 = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(255, 103, 142, 205),
  colorScheme: const ColorScheme.dark(
    surface: Color.fromARGB(255, 62, 96, 150),
    primary: Color.fromARGB(255, 90, 130, 194),
    onPrimary: Color.fromARGB(255, 244, 210, 218),
    inversePrimary: Color.fromARGB(255, 244, 210, 218),
    secondary: Color.fromARGB(255, 232, 134, 156),
    onSurface: Color.fromARGB(255, 250, 170, 187),
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
        Color.fromARGB(255, 242, 186, 199),
      ),
    ),
  ),
);

ThemeData lightTheme7 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 244, 210, 218),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 255, 179, 195),
    primary: Color.fromARGB(255, 244, 210, 218),
    onPrimary: Color.fromARGB(255, 90, 130, 194),
    inversePrimary: Color.fromARGB(255, 62, 96, 150),
    secondary: Color.fromARGB(255, 131, 167, 225),
    onSurface: Color.fromARGB(255, 62, 96, 150),
    tertiary: Color.fromARGB(255, 62, 96, 150),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
    displayMedium: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
    displaySmall: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
    headlineLarge: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
    headlineMedium: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
    labelLarge: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
    labelMedium: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
    labelSmall: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
    titleLarge: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
    titleMedium: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
    titleSmall: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
    bodyLarge: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
    bodySmall: TextStyle(color: Color.fromARGB(255, 62, 96, 150)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color.fromARGB(60, 90, 130, 194),
    cursorColor: Color.fromARGB(255, 90, 130, 194),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(
        Color.fromARGB(255, 62, 96, 150),
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
  scaffoldBackgroundColor: const Color.fromARGB(255, 189, 108, 125),
  colorScheme: const ColorScheme.dark(
    surface: Color.fromARGB(255, 156, 81, 97),
    primary: Color.fromARGB(255, 209, 111, 132),
    onPrimary: Color.fromARGB(255, 244, 210, 218),
    inversePrimary: Color.fromARGB(255, 244, 210, 218),
    secondary: Color.fromARGB(255, 219, 112, 135),
    onSurface: Color.fromARGB(255, 250, 170, 187),
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
        Color.fromARGB(255, 242, 186, 199),
      ),
    ),
  ),
);

ThemeData lightTheme9 = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 252, 230, 235),
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 248, 193, 205),
    primary: Color.fromARGB(255, 228, 138, 158),
    onPrimary: Color.fromARGB(255, 252, 230, 235),
    inversePrimary: Color.fromARGB(255, 154, 28, 55),
    secondary: Color.fromARGB(255, 255, 133, 160),
    onSurface: Color.fromARGB(255, 187, 53, 82),
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
        Color.fromARGB(255, 154, 28, 55),
      ),
    ),
  ),
);
