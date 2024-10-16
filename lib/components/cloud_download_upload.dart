import 'package:flutter/material.dart';
import 'package:honeydo/providers/sync_card_provider.dart';
import 'package:provider/provider.dart';

class CloudDownloadUpload extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final String describeText;
  const CloudDownloadUpload({
    super.key,
    this.margin,
    required this.describeText,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: margin,
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
                    const Icon(Icons.file_upload_outlined),
                    const SizedBox(height: 4),
                    Selector<SyncCardProvider, String>(
                      selector: (context, provider) => '${provider.dataBytesTransferredDownload.toStringAsFixed(2)} / ${provider.dataTotalBytesDownload.toStringAsFixed(2)}',
                      builder: (context, dataText, child) {
                        return Text(
                          dataText,
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Selector<SyncCardProvider, double>(
                    selector: (context, provider) => provider.downloadProgress,
                    builder: (context, downloadProgress, child) {
                      return CircularProgressIndicator(
                        value: downloadProgress,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        color: Theme.of(context).colorScheme.tertiary,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              describeText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
