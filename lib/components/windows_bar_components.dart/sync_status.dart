import 'package:flutter/material.dart';

class SyncStatus extends StatelessWidget {
  const SyncStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {},
                    label: Text(
                      'sefa__uzun61_ts_uzun@gmail.com',
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
            'Verileri cihaza indir',
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
