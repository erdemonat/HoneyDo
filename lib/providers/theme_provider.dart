import 'package:flutter/material.dart';
import 'package:honeydo/constants/theme.dart';

class ThemeProvider extends ChangeNotifier {
  int get currentThemeIndex => _currentThemeIndex;
  bool get isDarkMode => _isDarkMode;

  final List<ThemeData> _darkThemes = [
    darkTheme8,
    darkTheme1,
    darkTheme3,
    darkTheme2,
    darkTheme5,
    darkTheme4,
    darkTheme7,
    darkTheme6,
    darkTheme9,
  ];

  final List<ThemeData> _lightThemes = [
    lightTheme8,
    lightTheme1,
    lightTheme3,
    lightTheme2,
    lightTheme5,
    lightTheme4,
    lightTheme7,
    lightTheme6,
    lightTheme9,
  ];

  bool _isDarkMode = true;
  int _currentThemeIndex = 0;

  ThemeData get getThemeData => _isDarkMode
      ? _darkThemes[_currentThemeIndex]
      : _lightThemes[_currentThemeIndex];

  Color getThemePrimaryColor(int index) {
    if (index >= 0 && index < _darkThemes.length) {
      return _isDarkMode
          ? _darkThemes[index].colorScheme.primary
          : _lightThemes[index].colorScheme.primary;
    }
    return Colors.transparent;
  }

  Color getThemeTertiaryColor(int index) {
    if (index >= 0 && index < _darkThemes.length) {
      return _isDarkMode
          ? _darkThemes[index].colorScheme.tertiary
          : _lightThemes[index].colorScheme.tertiary;
    }
    return Colors.transparent;
  }

  void switchTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void switchThemeIndex(int index) {
    if (index >= 0 &&
        index < (_isDarkMode ? _darkThemes.length : _lightThemes.length)) {
      _currentThemeIndex = index;
      notifyListeners();
    }
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
