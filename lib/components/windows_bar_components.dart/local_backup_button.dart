import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalBackUpButton extends StatelessWidget {
  final void Function()? onPressed;
  const LocalBackUpButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Expanded(
        child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.computer_rounded,
              size: 55,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            Text(
              appLocalizations.exportImportData,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    ));
  }
}
