import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var buttonColors = WindowButtonColors(
      normal: Colors.transparent,
      iconNormal: Theme.of(context).colorScheme.tertiary,
      mouseOver:
          Theme.of(context).colorScheme.primary,
      mouseDown: Theme.of(context).colorScheme.onPrimary,
      iconMouseOver: Theme.of(context).colorScheme.tertiary,
      iconMouseDown: Theme.of(context).colorScheme.onSurface,
    );
    return Row(
      children: [
        MinimizeWindowButton(
          colors: buttonColors,
        ),
        MaximizeWindowButton(
          colors: buttonColors,
        ),
        CloseWindowButton(
          colors: buttonColors,
        ),
      ],
    );
  }
}
