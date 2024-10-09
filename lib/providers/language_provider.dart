import 'package:flutter/material.dart';
import 'package:honeydo/main.dart';

class LanguageProvider extends ChangeNotifier {
  int get languageIndex => _languageIndex;
  List<String> get languageCode => _languageCode;
  List<String> get weatherLanguageCode => _weatherLanguageCode;

  int _languageIndex = 0;

  final List<String> _languageCode = [
    "en_EN",
    "tr_TR"
  ];

  final List<String> _weatherLanguageCode = [
    "en",
    "tr"
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
