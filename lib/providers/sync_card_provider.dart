import 'package:flutter/material.dart';

class SyncCardProvider extends ChangeNotifier {
  bool _isLoginMode = true;
  bool _isLocalBackUp = false;
  bool _isLogined = false;
  bool _isCloudBackUp = false;
  bool _showAuthScreen = false;

  bool get isLoginMode => _isLoginMode;
  bool get isLocalBackUp => _isLocalBackUp;
  bool get isLogined => _isLogined;
  bool get isCloudBackUp => _isCloudBackUp;
  bool get showAuthScreen => _showAuthScreen;

  void toggleLoginMode() {
    _isLoginMode = !_isLoginMode;
    notifyListeners();
  }

  void setLoginMode(bool value) {
    _isLoginMode = value;
    notifyListeners();
  }

  void toggleLocalBackUp() {
    _isLocalBackUp = !_isLocalBackUp;
    notifyListeners();
  }

  void setLocalBackUp(bool value) {
    _isLocalBackUp = value;
    notifyListeners();
  }

  void toggleLogined() {
    _isLogined = !_isLogined;
    notifyListeners();
  }

  void toggleCloudBackUp() {
    _isCloudBackUp = !_isCloudBackUp;
    notifyListeners();
  }

  void setCloudBackUp(bool value) {
    _isCloudBackUp = value;
    notifyListeners();
  }

  void toggleAuth() {
    _showAuthScreen = !_showAuthScreen;
    notifyListeners();
  }

  void showLocalBackup() {
    _isLocalBackUp = true;
    notifyListeners();
  }

  void resetSyncCardState() {
    _isLocalBackUp = false;
    _isCloudBackUp = false;
    _isLoginMode = true;
    _showAuthScreen = false;
  }
}
