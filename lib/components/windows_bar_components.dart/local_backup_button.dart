import 'package:flutter/material.dart';

class LocalBackUpButton extends StatelessWidget {
  final void Function()? onPressed;
  const LocalBackUpButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
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
            const Text(
              'Verilerinizi \niçe veya dışa \naktarın',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    ));
  }
}
