import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/user_preferences_model.dart';
import 'package:honeydo/screens/auth.dart';

class SyncCardProvider extends ChangeNotifier {
  Timer? _debounceTimer;

  // Auth
  bool _isLoginMode = true;
  bool _isPasswordResetMode = false;
  bool _isLocalBackUp = false;
  // Sync Status
  bool _isUploadMode = false;
  bool _isDownloadMode = false;
  bool _isUploadConfirmation = false;
  bool _isDownloadConfirmation = false;
  bool _isSignOutMode = false;
  double _uploadProgress = 0;
  double _dataBytesTransferredUpload = 0;
  double _dataTotalBytesUpload = 0;
  double _downloadProgress = 0;
  double _dataBytesTransferredDownload = 0;
  double _dataTotalBytesDownload = 0;
  String _lastUploadTime = "";
  String _lastDownloadTime = "";

  bool get isLoginMode => _isLoginMode;
  bool get isLocalBackUp => _isLocalBackUp;
  bool get isPasswordResetMode => _isPasswordResetMode;
  bool get isUploadMode => _isUploadMode;
  bool get isDownloadMode => _isDownloadMode;
  bool get isUploadConfirmation => _isUploadConfirmation;
  bool get isDownloadConfirmation => _isDownloadConfirmation;
  bool get isSignOutMode => _isSignOutMode;
  double get uploadProgress => _uploadProgress;
  double get downloadProgress => _downloadProgress;
  double get dataBytesTransferredUpload => _dataBytesTransferredUpload;
  double get dataBytesTransferredDownload => _dataBytesTransferredDownload;
  double get dataTotalBytesUpload => _dataTotalBytesUpload;
  double get dataTotalBytesDownload => _dataBytesTransferredDownload;
  String get lastUploadTime => _lastUploadTime;
  String get lastDownloadTime => _lastDownloadTime;

  void toggleLoginMode() {
    _isLoginMode = !_isLoginMode;
    notifyListeners();
  }

  void setLoginMode(bool value) {
    _isLoginMode = value;
    notifyListeners();
  }

  void setSignOutMode(bool value) {
    _isSignOutMode = value;
    notifyListeners();
  }

  void setIsUploadMode(bool value) {
    _isUploadMode = value;
    notifyListeners();
  }

  void setIsUploadConfirmation(bool value) {
    _isUploadConfirmation = value;
    notifyListeners();
  }

  void setIsDownloadConfirmation(bool value) {
    _isDownloadConfirmation = value;
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
    _isDownloadConfirmation = false;
    _isUploadConfirmation = false;
    notifyListeners();
  }

  void startBackup() async {
    _isUploadMode = true;
    _isUploadConfirmation = false;
    notifyListeners();

    await isarService.createCloudBackUp((double bytesTransferred, double totalBytes) {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        _uploadProgress = bytesTransferred / totalBytes;
        _dataBytesTransferredUpload = bytesTransferred;
        _dataTotalBytesUpload = totalBytes;
        notifyListeners();
      });
    });

    _isUploadMode = false;
    getFileMetadata();
    notifyListeners();
  }

  void startRestoreDB() async {
    _isDownloadMode = true;
    _isDownloadConfirmation = false;
    notifyListeners();

    await isarService.restoreDBOnCloud((double bytesTransferred, double totalBytes) {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        _downloadProgress = bytesTransferred / totalBytes;
        _dataBytesTransferredDownload = bytesTransferred;
        _dataTotalBytesDownload = totalBytes;
        notifyListeners();
      });
    });

    _isDownloadMode = false;
    getFileMetadata();
    notifyListeners();
  }

  Future<void> getFileMetadata() async {
    final isar = await isarService.db;
    var currentUserUID = auth.currentUser!.uid;
    var fileName = "$currentUserUID.isar";
    var oldLastUploadTime = _lastUploadTime;
    var oldLastDownloadTime = _lastDownloadTime;
    try {
      final storageRef = FirebaseStorage.instance.ref().child(currentUserUID).child(fileName);
      final FullMetadata metadata = await storageRef.getMetadata();

      if (metadata.customMetadata != null) {
        final uploadDateLocal = metadata.customMetadata?['uploadDateLocal'];
        _lastUploadTime = uploadDateLocal!;
      } else {
        _lastUploadTime = "";
      }
    } catch (e) {}

    try {
      final cloudMetaData = await isar.cloudMetaDatas.get(4);

      if (cloudMetaData != null && cloudMetaData.lastDownloadTime != null) {
        _lastDownloadTime = cloudMetaData.lastDownloadTime!;
      } else {
        _lastDownloadTime = "";
      }
    } catch (e) {
      _lastDownloadTime = "";
    }
    if (_lastDownloadTime != oldLastDownloadTime || _lastUploadTime != oldLastUploadTime) notifyListeners();
  }
}
