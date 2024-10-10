import 'dart:io';

import 'package:flutter/material.dart';
import 'package:honeydo/service/isar_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path/path.dart' as path;

class ImportLocalButton extends StatelessWidget {
  const ImportLocalButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          await IsarService().restoreDB();
          restartApp();
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.file_download_outlined,
                size: 55,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              Text(
                AppLocalizations.of(context)!.importData,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void restartApp() async {
  // Mevcut uygulamanın executable yolunu buluyoruz
  final executable = Platform.resolvedExecutable;
  final script = Platform.script.toFilePath();
  final workingDirectory = path.dirname(script);

  // Uygulamayı yeniden çalıştır
  await Process.start(executable, [], workingDirectory: workingDirectory);

  // Uygulamayı kapat
  exit(0);
}
