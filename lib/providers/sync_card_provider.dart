import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/user_preferences_model.dart';
import 'package:honeydo/screens/auth.dart';

class SyncCardState {
  final bool isLoginMode;
  final bool isPasswordResetMode;
  final bool isLocalBackUp;
  final bool isUploadMode;
  final bool isDownloadMode;
  final bool isUploadConfirmation;
  final bool isDownloadConfirmation;
  final bool isSignOutMode;
  final double uploadProgress;
  final double dataBytesTransferredUpload;
  final double dataTotalBytesUpload;
  final double downloadProgress;
  final double dataBytesTransferredDownload;
  final double dataTotalBytesDownload;
  final String lastUploadTime;
  final String lastDownloadTime;

  SyncCardState({
    this.isLoginMode = true,
    this.isPasswordResetMode = false,
    this.isLocalBackUp = false,
    this.isUploadMode = false,
    this.isDownloadMode = false,
    this.isUploadConfirmation = false,
    this.isDownloadConfirmation = false,
    this.isSignOutMode = false,
    this.uploadProgress = 0,
    this.dataBytesTransferredUpload = 0,
    this.dataTotalBytesUpload = 0,
    this.downloadProgress = 0,
    this.dataBytesTransferredDownload = 0,
    this.dataTotalBytesDownload = 0,
    this.lastUploadTime = "",
    this.lastDownloadTime = "",
  });

  SyncCardState copyWith({
    bool? isLoginMode,
    bool? isPasswordResetMode,
    bool? isLocalBackUp,
    bool? isUploadMode,
    bool? isDownloadMode,
    bool? isUploadConfirmation,
    bool? isDownloadConfirmation,
    bool? isSignOutMode,
    double? uploadProgress,
    double? dataBytesTransferredUpload,
    double? dataTotalBytesUpload,
    double? downloadProgress,
    double? dataBytesTransferredDownload,
    double? dataTotalBytesDownload,
    String? lastUploadTime,
    String? lastDownloadTime,
  }) {
    return SyncCardState(
      isLoginMode: isLoginMode ?? this.isLoginMode,
      isPasswordResetMode: isPasswordResetMode ?? this.isPasswordResetMode,
      isLocalBackUp: isLocalBackUp ?? this.isLocalBackUp,
      isUploadMode: isUploadMode ?? this.isUploadMode,
      isDownloadMode: isDownloadMode ?? this.isDownloadMode,
      isUploadConfirmation: isUploadConfirmation ?? this.isUploadConfirmation,
      isDownloadConfirmation:
          isDownloadConfirmation ?? this.isDownloadConfirmation,
      isSignOutMode: isSignOutMode ?? this.isSignOutMode,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      dataBytesTransferredUpload:
          dataBytesTransferredUpload ?? this.dataBytesTransferredUpload,
      dataTotalBytesUpload: dataTotalBytesUpload ?? this.dataTotalBytesUpload,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      dataBytesTransferredDownload:
          dataBytesTransferredDownload ?? this.dataBytesTransferredDownload,
      dataTotalBytesDownload:
          dataTotalBytesDownload ?? this.dataTotalBytesDownload,
      lastUploadTime: lastUploadTime ?? this.lastUploadTime,
      lastDownloadTime: lastDownloadTime ?? this.lastDownloadTime,
    );
  }
}

class SyncCardNotifier extends StateNotifier<SyncCardState> {
  Timer? _debounceTimer;

  SyncCardNotifier() : super(SyncCardState());

  void toggleLoginMode() {
    state = state.copyWith(isLoginMode: !state.isLoginMode);
  }

  void setLoginMode(bool value) {
    state = state.copyWith(isLoginMode: value);
  }

  void setSignOutMode(bool value) {
    state = state.copyWith(isSignOutMode: value);
  }

  void setIsUploadMode(bool value) {
    state = state.copyWith(isUploadMode: value);
  }

  void setIsUploadConfirmation(bool value) {
    state = state.copyWith(isUploadConfirmation: value);
  }

  void setIsDownloadConfirmation(bool value) {
    state = state.copyWith(isDownloadConfirmation: value);
  }

  void setPasswordResetMode(bool value) {
    state = state.copyWith(isPasswordResetMode: value);
  }

  void toggleLocalBackUp() {
    state = state.copyWith(isLocalBackUp: !state.isLocalBackUp);
  }

  void showLocalBackup() {
    state = state.copyWith(isLocalBackUp: true);
  }

  void resetSyncCardState() {
    state = SyncCardState();
  }

  Future<void> startBackup() async {
    state = state.copyWith(isUploadMode: true, isUploadConfirmation: false);

    await isarService
        .createCloudBackUp((double bytesTransferred, double totalBytes) {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        state = state.copyWith(
          uploadProgress: bytesTransferred / totalBytes,
          dataBytesTransferredUpload: bytesTransferred,
          dataTotalBytesUpload: totalBytes,
        );
      });
    });

    state = state.copyWith(isUploadMode: false);
    await getFileMetadata();
  }

  Future<void> startRestoreDB() async {
    state = state.copyWith(isDownloadMode: true, isDownloadConfirmation: false);

    await isarService
        .restoreDBOnCloud((double bytesTransferred, double totalBytes) {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        state = state.copyWith(
          downloadProgress: bytesTransferred / totalBytes,
          dataBytesTransferredDownload: bytesTransferred,
          dataTotalBytesDownload: totalBytes,
        );
      });
    });

    state = state.copyWith(isDownloadMode: false);
    await getFileMetadata();
  }

  Future<void> getFileMetadata() async {
    final isar = await isarService.db;
    var currentUserUID = auth.currentUser!.uid;
    var fileName = "$currentUserUID.isar";
    var oldLastUploadTime = state.lastUploadTime;
    var oldLastDownloadTime = state.lastDownloadTime;
    String lastUploadTime = state.lastUploadTime;
    String lastDownloadTime = state.lastDownloadTime;

    try {
      final storageRef =
          FirebaseStorage.instance.ref().child(currentUserUID).child(fileName);
      final FullMetadata metadata = await storageRef.getMetadata();

      if (metadata.customMetadata != null) {
        final uploadDateLocal = metadata.customMetadata?['uploadDateLocal'];
        lastUploadTime = uploadDateLocal!;
      } else {
        lastUploadTime = "";
      }
    } catch (e) {
      // Hata yönetimi
    }

    try {
      final cloudMetaData = await isar.cloudMetaDatas.get(4);

      if (cloudMetaData != null && cloudMetaData.lastDownloadTime != null) {
        lastDownloadTime = cloudMetaData.lastDownloadTime!;
      } else {
        lastDownloadTime = "";
      }
    } catch (e) {
      lastDownloadTime = "";
    }

    if (lastDownloadTime != oldLastDownloadTime ||
        lastUploadTime != oldLastUploadTime) {
      state = state.copyWith(
        lastUploadTime: lastUploadTime,
        lastDownloadTime: lastDownloadTime,
      );
    }
  }
}

final syncCardProvider =
    StateNotifierProvider<SyncCardNotifier, SyncCardState>((ref) {
  return SyncCardNotifier();
});
