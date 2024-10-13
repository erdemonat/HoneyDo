import 'package:flutter/material.dart';
import 'package:honeydo/service/isar_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExportLocalButton extends StatelessWidget {
  const ExportLocalButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          await IsarService().createBackUp();
        },
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
              Icon(
                Icons.upload_file_outlined,
                size: 55,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(height: 25),
              Text(
                AppLocalizations.of(context)!.exportData,
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
