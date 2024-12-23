import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honeydo/components/export_import_button.dart';
import 'package:honeydo/providers/sync_card_provider.dart';
import 'package:honeydo/screens/auth.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class SyncStatus extends ConsumerWidget {
  const SyncStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    final SyncCardState syncCardState = ref.watch(syncCardProvider);
    final SyncCardNotifier syncCardNotifier =
        ref.read(syncCardProvider.notifier);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 42,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: syncCardState.isSignOutMode
                  ? const EdgeInsets.all(2)
                  : const EdgeInsets.only(left: 14.0, top: 5, right: 5),
              child: syncCardState.isSignOutMode
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConfirmationSlider(
                          text: appLocalizations.swipeToLogout,
                          textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 11),
                          sliderButtonContent: const SizedBox(),
                          iconColor: Theme.of(context).colorScheme.tertiary,
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          foregroundColor:
                              Theme.of(context).colorScheme.onSurface,
                          width: 250,
                          height: 25,
                          onTapUp: () => syncCardNotifier.setSignOutMode(false),
                          onConfirmation: () {
                            auth.signOut();
                            syncCardNotifier.setSignOutMode(false);
                          },
                        )
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          auth.currentUser?.email ?? '',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () =>
                              syncCardNotifier.setSignOutMode(true),
                          icon: Icon(
                            Icons.logout,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.surface,
              ),
              width: double.infinity,
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  syncCardState.isUploadConfirmation
                      ? Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 25),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  appLocalizations.lastUpload,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiary
                                        .withOpacity(0.6),
                                  ),
                                ),
                                Text(
                                  syncCardState.lastUploadTime,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiary
                                        .withOpacity(0.6),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  appLocalizations.confirmUpload,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        syncCardNotifier
                                            .setIsUploadConfirmation(false);
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                    const SizedBox(width: 24),
                                    IconButton(
                                      onPressed: () {
                                        syncCardNotifier.startBackup();
                                      },
                                      icon: const Icon(Icons.done),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      : syncCardState.isUploadMode
                          ? Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 25),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            const Icon(
                                                Icons.file_upload_outlined),
                                            const SizedBox(height: 4),
                                            Text(
                                              "${syncCardState.dataBytesTransferredUpload.toStringAsFixed(2)} / ${syncCardState.dataTotalBytesUpload.toStringAsFixed(2)}",
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: CircularProgressIndicator(
                                            value: syncCardState.uploadProgress,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      appLocalizations.uploading,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ExportImportButton(
                              buttonText: appLocalizations.uploadToCloud,
                              onTap: () async {
                                syncCardNotifier.setIsUploadConfirmation(true);
                              },
                              subtitleText: Column(
                                children: [
                                  Text(
                                    appLocalizations.lastUpload,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                  Text(
                                    syncCardState.lastUploadTime,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                              icon: Symbols.cloud_upload,
                              margin: const EdgeInsets.only(left: 25),
                            ),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: VerticalDivider(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  syncCardState.isDownloadConfirmation
                      ? Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 25),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  appLocalizations.lastDownload,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiary
                                        .withOpacity(0.6),
                                  ),
                                ),
                                Text(
                                  syncCardState.lastDownloadTime,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiary
                                        .withOpacity(0.6),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  appLocalizations.confirmDownload,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        syncCardNotifier
                                            .setIsDownloadConfirmation(false);
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                    const SizedBox(width: 24),
                                    IconButton(
                                      onPressed: () {
                                        syncCardNotifier.startRestoreDB();
                                      },
                                      icon: const Icon(Icons.done),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      : syncCardState.isDownloadMode
                          ? Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 25),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            const Icon(
                                                Icons.file_download_outlined),
                                            const SizedBox(height: 4),
                                            Text(
                                              "${syncCardState.dataBytesTransferredDownload.toStringAsFixed(2)} / ${syncCardState.dataTotalBytesDownload.toStringAsFixed(2)}",
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: CircularProgressIndicator(
                                            value:
                                                syncCardState.downloadProgress,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      appLocalizations.downloading,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ExportImportButton(
                              buttonText: appLocalizations.downloadFromCloud,
                              onTap: () => syncCardNotifier
                                  .setIsDownloadConfirmation(true),
                              icon: Symbols.cloud_download,
                              margin: const EdgeInsets.only(right: 25),
                              subtitleText: Column(
                                children: [
                                  Text(
                                    appLocalizations.lastDownload,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                  Text(
                                    syncCardState.lastDownloadTime,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                ],
              )),
        ),
      ],
    );
  }
}
