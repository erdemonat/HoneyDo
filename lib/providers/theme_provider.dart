import 'package:flutter/material.dart';
import 'package:honeydo/constants/theme.dart';

class ThemeProvider extends ChangeNotifier {
  // Tema listeleri (6 dark, 6 light)
  final List<ThemeData> _darkThemes = [
    darkTheme1,
    darkTheme2,
    darkTheme3,
    darkTheme4,
    darkTheme5,
    darkTheme6,
  ];

  final List<ThemeData> _lightThemes = [
    lightTheme1,
    lightTheme2,
    lightTheme3,
    lightTheme4,
    lightTheme5,
    lightTheme6,
  ];

  bool _isDarkMode = true; // Dark mode açık mı?
  int _currentThemeIndex = 0; // Aktif tema indeksi

  // Geçerli tema (dark veya light moduna göre)
  ThemeData get getThemeData => _isDarkMode
      ? _darkThemes[_currentThemeIndex]
      : _lightThemes[_currentThemeIndex];

  Color getThemePrimaryColor(int index) {
    if (index >= 0 && index < _darkThemes.length) {
      return _isDarkMode
          ? _darkThemes[index].colorScheme.primary
          : _lightThemes[index].colorScheme.primary;
    }
    return Colors.transparent; // Geçersiz index için varsayılan değer
  }

  Color getThemeTertiaryColor(int index) {
    if (index >= 0 && index < _darkThemes.length) {
      return _isDarkMode
          ? _darkThemes[index].colorScheme.tertiary
          : _lightThemes[index].colorScheme.tertiary;
    }
    return Colors.transparent; // Geçersiz index için varsayılan değer
  }

  // Temayı değiştirir (dark-light geçişi ve tema numarasına göre)
  void switchTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Tema indexini değiştirir
  void switchThemeIndex(int index) {
    if (index >= 0 &&
        index < (_isDarkMode ? _darkThemes.length : _lightThemes.length)) {
      _currentThemeIndex = index;
      notifyListeners();
    }
  }

  // Mevcut modun dark/light olup olmadığını değiştir
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Mevcut temayı getirir
  int get currentThemeIndex => _currentThemeIndex;

  // Dark mode açık mı kontrolü
  bool get isDarkMode => _isDarkMode;
}
