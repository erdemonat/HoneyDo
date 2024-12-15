import 'package:flutter/material.dart';
import 'package:honeydo/main.dart';

class LanguageProvider extends ChangeNotifier {
  // Singleton instance
  static final LanguageProvider _instance = LanguageProvider._internal();

  // Private constructor
  LanguageProvider._internal();

  // Factory constructor to return the singleton instance
  factory LanguageProvider() {
    return _instance;
  }

  int get languageIndex => _languageIndex;
  List<String> get languageCode => _languageCode;
  List<String> get weatherLanguageCode => _weatherLanguageCode;

  int _languageIndex = 0;

  final List<String> _languageCode = [
    "de_DE",
    "en_EN",
    "es_ES",
    "fr_FR",
    "ja_JP",
    "ko_KR",
    "ru_RU",
    "tr_TR",
    "zh_CN",
  ];

  final List<String> _weatherLanguageCode = [
    "de",
    "en",
    "es",
    "fr",
    "ja",
    "kr",
    "ru",
    "tr",
    "zh_cn",
  ];

  void changeLanguage(index) {
    _languageIndex = index;
    notifyListeners();
  }

  String getLanguageCode() {
    return _languageCode[_languageIndex];
  }

  String getWeatherLanguageCode() {
    return _weatherLanguageCode[_languageIndex];
  }

  Future<void> saveLanguage() async {}

  Future<void> loadLanguage() async {
    changeLanguage(await isarService.getLanguage());
    notifyListeners();
  }
}
