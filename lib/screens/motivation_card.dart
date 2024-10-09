import 'package:flutter/material.dart';
import 'package:honeydo/data/random_sentence.dart';
import 'package:honeydo/providers/language_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MotivationCard extends StatelessWidget {
  const MotivationCard({super.key});

  @override
  Widget build(BuildContext context) {
    String motivationSentence = selectRandomSentence(context);
    DateTime now = DateTime.now();
    String formattedTimeWithoutYear = DateFormat('d MMMM', Provider.of<LanguageProvider>(context, listen: false).getLanguageCode()).format(now);
    return LayoutBuilder(
      builder: (context, constraints) {
        double fontSize = (constraints.maxHeight / 5).clamp(10, 35);

        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.today,
                style: TextStyle(fontSize: fontSize * 0.6),
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
