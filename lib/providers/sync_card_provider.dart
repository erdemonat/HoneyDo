import 'package:flutter/material.dart';

class SyncCardProvider extends ChangeNotifier {
  bool _isLoginMode = true;
  bool _isPasswordResetMode = false;
  bool _isLocalBackUp = false;

  bool get isLoginMode => _isLoginMode;
  bool get isLocalBackUp => _isLocalBackUp;
  bool get isPasswordResetMode => _isPasswordResetMode;

  void toggleLoginMode() {
    _isLoginMode = !_isLoginMode;
    notifyListeners();
  }

  void setLoginMode(bool value) {
    _isLoginMode = value;
    notifyListeners();
  }

  void setPasswordResetMode(bool isPasswordResetMode) {
    _isPasswordResetMode = isPasswordResetMode;
    notifyListeners();
  }

  void toggleLocalBackUp() {
    _isLocalBackUp = !_isLocalBackUp;
    notifyListeners();
  }

  void showLocalBackup() {
    _isLocalBackUp = true;
    notifyListeners();
  }

  void resetSyncCardState() {
    _isLocalBackUp = false;
    _isLoginMode = true;
    _isPasswordResetMode = false;
    notifyListeners();
  }
}
