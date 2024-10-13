import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/screens/sync_card.dart';
import 'package:honeydo/main.dart';

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var buttonColors = WindowButtonColors(
      normal: Colors.transparent,
      iconNormal: Theme.of(context).colorScheme.tertiary,
      mouseOver: Theme.of(context).colorScheme.primary,
      mouseDown: Theme.of(context).colorScheme.onPrimary,
      iconMouseOver: Theme.of(context).colorScheme.tertiary,
      iconMouseDown: Theme.of(context).colorScheme.onSurface,
    );
    return Row(
      children: [
        const SyncButton(),
        MinimizeWindowButton(
          colors: buttonColors,
        ),
        MaximizeWindowButton(
          colors: buttonColors,
        ),
        CloseWindowButton(
          onPressed: () async {
            await isarService.saveWindowSizeAndPosition();
            appWindow.close();
          },
          colors: buttonColors,
        ),
      ],
    );
  }
}
