import 'package:flutter/material.dart';

class DayBubble extends StatelessWidget {
  const DayBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 130),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text("Pazar"),
              Text("17"),
            ],
          ),
        ),
      ),
    );
  }
}
