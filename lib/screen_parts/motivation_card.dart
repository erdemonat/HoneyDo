import 'package:flutter/material.dart';
import 'package:honeydo/components/personal_info.dart';
import 'package:honeydo/data/random_sentence.dart';
import 'package:intl/intl.dart';

class MotivationCard extends StatelessWidget {
  const MotivationCard({super.key});

  static String motivationSentence = selectRandomSentence();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTimeWithoutYear = DateFormat('d MMMM', 'tr_TR').format(now);
    return LayoutBuilder(
      builder: (context, constraints) {
        double fontSize = (constraints.maxWidth / 10).clamp(10, 35);

        return Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bugün',
                    style: TextStyle(fontSize: fontSize * 0.6),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PersonalInfoDialog();
                        },
                      );
                    },
                    icon: Icon(Icons.person),
                  ),
                ],
              ),
              Text(
                formattedTimeWithoutYear,
                maxLines: 1,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                motivationSentence,
                softWrap: true,
                maxLines: 2,
                style: TextStyle(fontSize: fontSize * 0.5),
              ),
            ],
          ),
        );
      },
    );
  }
}
