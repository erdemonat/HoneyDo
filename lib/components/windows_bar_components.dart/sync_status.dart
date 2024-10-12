import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:honeydo/screens/auth.dart';

class SyncStatus extends StatelessWidget {
  const SyncStatus({
    super.key,
  });

  Future<void> signOut(BuildContext context) async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () => signOut(context),
                    label: Text(
                      auth.currentUser?.email ?? '',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    icon: Icon(
                      Icons.logout_rounded,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text(
                      'Son eşitleme: 18.09.2024 - 22:36',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    icon: Icon(Icons.sync,
                        color: Theme.of(context).colorScheme.onSurface),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Divider(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        TextButton.icon(
          onPressed: () {},
          label: Text(
            appLocalizations.downloadData,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          icon: Icon(Icons.file_download_outlined,
              size: 20, color: Theme.of(context).colorScheme.onPrimary),
        ),
      ],
    );
  }
}
