import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String randomTaskSentences(BuildContext context) {
  final List<String> taskSentences = [
    AppLocalizations.of(context)!.taskCardSentence1,
    AppLocalizations.of(context)!.taskCardSentence2,
    AppLocalizations.of(context)!.taskCardSentence3,
    AppLocalizations.of(context)!.taskCardSentence4,
    AppLocalizations.of(context)!.taskCardSentence5,
    AppLocalizations.of(context)!.taskCardSentence6,
    AppLocalizations.of(context)!.taskCardSentence7,
    AppLocalizations.of(context)!.taskCardSentence8,
    AppLocalizations.of(context)!.taskCardSentence9,
    AppLocalizations.of(context)!.taskCardSentence10,
  ];
  final random = Random();
  return taskSentences[random.nextInt(taskSentences.length)];
}
