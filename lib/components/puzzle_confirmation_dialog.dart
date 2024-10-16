import 'dart:math';

import 'package:flutter/material.dart';
import 'package:honeydo/providers/sync_card_provider.dart';
import 'package:provider/provider.dart';

class PuzzleConfirmationDialog extends StatefulWidget {
  @override
  _PuzzleConfirmationDialogState createState() => _PuzzleConfirmationDialogState();
}

class _PuzzleConfirmationDialogState extends State<PuzzleConfirmationDialog> {
  List<int> numbers = [];
  List<int> correctSequence = [
    1,
    2,
    3,
    4,
  ];

  @override
  void initState() {
    super.initState();
    resetPuzzle();
  }

  void resetPuzzle() {
    numbers = List<int>.from(correctSequence);
    numbers.shuffle(Random());
  }

  void checkPuzzle(int number) {
    final SyncCardProvider syncCardProvider = Provider.of(context, listen: false);
    if (number == correctSequence.first) {
      setState(() {
        correctSequence.removeAt(0);
      });

      if (correctSequence.isEmpty) {
        syncCardProvider.startBackup();
        Navigator.of(context).pop(); // Puzzle tamamlandı, dialog kapansın
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Cloud transferi onaylandı!'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cloud transferini onaylıyor musunuz?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Onaylamak için puzzle çözün'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: numbers
                .map(
                  (number) => ElevatedButton(
                    onPressed: correctSequence.contains(number) ? () => checkPuzzle(number) : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(60, 60),
                      backgroundColor: correctSequence.contains(number) ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error,
                    ),
                    child: Text(
                      number.toString(),
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('İptal'),
        ),
      ],
    );
  }
}
