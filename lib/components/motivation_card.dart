import 'package:flutter/material.dart';
import 'package:honeydo/data/random_sentence.dart';
import 'package:intl/intl.dart';

class MotivationCard extends StatelessWidget {
  const MotivationCard({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTimeWithoutYear = DateFormat('d MMMM', 'tr_TR').format(now);
    String formattedTimeOnlyYear = DateFormat('yyyy', 'tr_TR').format(now);
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
      ),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Bugün'),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              formattedTimeWithoutYear,
              maxLines: 1,
              style: TextStyle(fontSize: 25),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              selectRandomSentence(),
              softWrap: true,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
