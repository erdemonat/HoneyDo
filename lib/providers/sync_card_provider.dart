import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/screens/auth.dart';
import 'package:intl/intl.dart';

class SyncCardProvider extends ChangeNotifier {
  Timer? _debounceTimer;

  // Auth
  bool _isLoginMode = true;
  bool _isPasswordResetMode = false;
  bool _isLocalBackUp = false;
  // Sync Status
  bool _isUploadMode = false;
  double _uploadProgress = 0;
  double _dataBytesTransferred = 0;
  double _dataTotalBytes = 0;

  bool get isLoginMode => _isLoginMode;
  bool get isLocalBackUp => _isLocalBackUp;
  bool get isPasswordResetMode => _isPasswordResetMode;
  bool get isUploadMode => _isUploadMode;
  double get uploadProgress => _uploadProgress;
  double get databytesTransferred => _dataBytesTransferred;
  double get datatotalBytes => _dataTotalBytes;

  void toggleLoginMode() {
    _isLoginMode = !_isLoginMode;
    notifyListeners();
  }

  void setLoginMode(bool value) {
    _isLoginMode = value;
    notifyListeners();
  }

  void setIsUploadMode(bool value) {
    _isUploadMode = value;
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
    _isUploadMode = true;
    notifyListeners();

    await isarService.createCloudBackUp((double bytesTransferred, double totalBytes) {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        _uploadProgress = bytesTransferred / totalBytes;
        _dataBytesTransferred = bytesTransferred;
        _dataTotalBytes = totalBytes;
        notifyListeners();
      });
    });

    _isUploadMode = false;
    notifyListeners();
  }

  Future<void> getUploadDateFromMetadata() async {
    var currentUserUID = auth.currentUser!.uid;
    var fileName = "$currentUserUID.isar";
    var storageRef = FirebaseStorage.instance.ref().child(currentUserUID).child(fileName);

    // Get the file's metadata
    FullMetadata metadata = await storageRef.getMetadata();

    // Get the updated time (in UTC)
    DateTime updatedTimeUtc = metadata.updated!;

    // Convert UTC time to local time
    DateTime updatedTimeLocal = updatedTimeUtc.toLocal();

    // Format the date as a string
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(updatedTimeLocal);

    print('Upload Date (Local Time): $formattedDate');
  }
}
