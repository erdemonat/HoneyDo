import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:honeydo/components/export_import_button.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/providers/sync_card_provider.dart';
import 'package:honeydo/screens/auth.dart';
import 'package:provider/provider.dart';
import 'package:material_symbols_icons/symbols.dart';

class SyncStatus extends StatelessWidget {
  const SyncStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final SyncCardProvider syncCardProvider = Provider.of<SyncCardProvider>(context, listen: false);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 42,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0, top: 5, right: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    auth.currentUser?.email ?? '',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: auth.signOut,
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
                ExportImportButton(
                  buttonText: 'Verileri Eşitle',
                  onTap: () {},
                  subtitleText: Column(
                    children: [
                      Text(
                        'Son Yükleme: ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        '18.10.2024 15:15',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  icon: Symbols.cloud_sync_sharp,
                  margin: const EdgeInsets.only(left: 25, top: 18),
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: VerticalDivider(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                ExportImportButton(
                  buttonText: 'Verileri cihaza indir',
                  onTap: () {},
                  icon: Symbols.install_desktop,
                  margin: const EdgeInsets.only(right: 25),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.only(right: 8, top: 10),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           TextButton.icon(
    //             onPressed: () {},
    //             label: Text('logout', style: kCalendarDayTextStyle(context)),
    //             icon: const Icon(Icons.logout),
    //             iconAlignment: IconAlignment.end,
    //           ),
    //         ],
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(left: 24),
    //       child: Row(
    //         children: [
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Row(
    //                 children: [
    //                   const CircleAvatar(
    //                     radius: 6,
    //                     backgroundColor: Colors.green,
    //                   ),
    //                   const SizedBox(width: 8),
    //                   Text(auth.currentUser?.email ?? '', style: kCardTitleTextStyle(context)),
    //                 ],
    //               ),
    //               const SizedBox(height: 8),
    //               Row(
    //                 children: [
    //                   Text(
    //                     'Son eşitleme : ',
    //                     style: kCalendarDayTextStyle(context),
    //                   ),
    //                   const Text('18/10/2024 15:15'),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    //       child: Row(
    //         children: [
    //           TextButton.icon(
    //             iconAlignment: IconAlignment.end,
    //             onPressed: isarService.downloadDataToDevice,
    //             label: Text(
    //               appLocalizations.downloadData,
    //               style: kCalendarDayTextStyle(context),
    //             ),
    //             icon: Icon(
    //               Icons.file_download_outlined,
    //               size: 20,
    //               color: Theme.of(context).colorScheme.onPrimary,
    //             ),
    //           ),
    //           const Spacer(),
    //           TextButton(
    //             onPressed: () {},
    //             child: Text(
    //               'Verileri eşitle',
    //               style: kCardSubTitleTextStyle(context).copyWith(
    //                 fontSize: 14,
    //                 fontWeight: FontWeight.w600,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
