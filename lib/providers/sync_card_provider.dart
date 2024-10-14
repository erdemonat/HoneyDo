import 'package:flutter/material.dart';
import 'package:honeydo/main.dart';

class SyncCardProvider extends ChangeNotifier {
  // Auth
  bool _isLoginMode = true;
  bool _isPasswordResetMode = false;
  bool _isLocalBackUp = false;
  // Sync Status
  double _uploadProgress = 0;
  int _dataBytesTransferred = 0;
  int _dataTotalBytes = 0;

  bool get isLoginMode => _isLoginMode;
  bool get isLocalBackUp => _isLocalBackUp;
  bool get isPasswordResetMode => _isPasswordResetMode;
  double get uploadProgress => _uploadProgress;
  int get databytesTransferred => _dataBytesTransferred;
  int get datatotalBytes => _dataTotalBytes;

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

  void startBackup() async {
    await isarService.createCloudBackUp((int bytesTransferred, int totalBytes) {
      double progress = (bytesTransferred / totalBytes) * 100;
      _uploadProgress = progress;
      _dataBytesTransferred = bytesTransferred;
      _dataTotalBytes = totalBytes;
      notifyListeners();
    });
  }

  String uploadStatus() {
    if (_uploadProgress == 0) {
      return 'Son eşitleme: 18.09.2024 - 22:36';
    } else if (_uploadProgress < 100) {
      return 'Yükleme devam ediyor: ${_uploadProgress.toStringAsFixed(0)}%';
    } else {
      return 'Yükleme tamamlandı: ${_uploadProgress.toStringAsFixed(0)}%';
    }
  }
}
