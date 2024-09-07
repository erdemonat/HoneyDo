import 'package:flutter/foundation.dart';

class SettingsProvider extends ChangeNotifier {
  bool _showSettingCards = false;

  bool get showSettingCards => _showSettingCards;

  void toggleSettingsCard() {
    _showSettingCards = !_showSettingCards;
    notifyListeners();
  }
}
