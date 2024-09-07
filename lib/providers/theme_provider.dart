import 'package:flutter/material.dart';
import 'package:honeydo/theme.dart';

class ThemeProvider extends ChangeNotifier {
  // Tema listeleri (6 dark, 6 light)
  final List<ThemeData> _darkThemes = [
    darkTheme, // Varsayılan dark tema
    // Diğer dark temalar burada olacak
  ];

  final List<ThemeData> _lightThemes = [
    lightTheme, // Varsayılan light tema
    // Diğer light temalar burada olacak
  ];

  bool _isDarkMode = true; // Dark mode açık mı?
  int _currentThemeIndex = 0; // Aktif tema indeksi

  // Geçerli tema (dark veya light moduna göre)
  ThemeData get getThemeData => _isDarkMode
      ? _darkThemes[_currentThemeIndex]
      : _lightThemes[_currentThemeIndex];

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
