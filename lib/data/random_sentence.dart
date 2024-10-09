import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String selectRandomSentence(BuildContext context) {
  final List<String> sentences = [
    AppLocalizations.of(context)!.motivationSentence1,
    AppLocalizations.of(context)!.motivationSentence2,
    AppLocalizations.of(context)!.motivationSentence3,
    AppLocalizations.of(context)!.motivationSentence4,
    AppLocalizations.of(context)!.motivationSentence5,
    AppLocalizations.of(context)!.motivationSentence6,
    AppLocalizations.of(context)!.motivationSentence7,
    AppLocalizations.of(context)!.motivationSentence8,
    AppLocalizations.of(context)!.motivationSentence9,
    AppLocalizations.of(context)!.motivationSentence10,
    AppLocalizations.of(context)!.motivationSentence11,
    AppLocalizations.of(context)!.motivationSentence12,
    AppLocalizations.of(context)!.motivationSentence13,
    AppLocalizations.of(context)!.motivationSentence14,
    AppLocalizations.of(context)!.motivationSentence15,
    AppLocalizations.of(context)!.motivationSentence16,
    AppLocalizations.of(context)!.motivationSentence17,
    AppLocalizations.of(context)!.motivationSentence18,
    AppLocalizations.of(context)!.motivationSentence19,
    AppLocalizations.of(context)!.motivationSentence20,
    AppLocalizations.of(context)!.motivationSentence21,
    AppLocalizations.of(context)!.motivationSentence22,
    AppLocalizations.of(context)!.motivationSentence23,
    AppLocalizations.of(context)!.motivationSentence24,
    AppLocalizations.of(context)!.motivationSentence25,
    AppLocalizations.of(context)!.motivationSentence26,
    AppLocalizations.of(context)!.motivationSentence27,
    AppLocalizations.of(context)!.motivationSentence28,
    AppLocalizations.of(context)!.motivationSentence29,
    AppLocalizations.of(context)!.motivationSentence30,
    AppLocalizations.of(context)!.motivationSentence31,
    AppLocalizations.of(context)!.motivationSentence32,
    AppLocalizations.of(context)!.motivationSentence33,
    AppLocalizations.of(context)!.motivationSentence34,
    AppLocalizations.of(context)!.motivationSentence35,
    AppLocalizations.of(context)!.motivationSentence36,
    AppLocalizations.of(context)!.motivationSentence37,
    AppLocalizations.of(context)!.motivationSentence38,
    AppLocalizations.of(context)!.motivationSentence39,
    AppLocalizations.of(context)!.motivationSentence40,
    AppLocalizations.of(context)!.motivationSentence41,
    AppLocalizations.of(context)!.motivationSentence42,
    AppLocalizations.of(context)!.motivationSentence43,
    AppLocalizations.of(context)!.motivationSentence44,
    AppLocalizations.of(context)!.motivationSentence45,
    AppLocalizations.of(context)!.motivationSentence46,
    AppLocalizations.of(context)!.motivationSentence47,
    AppLocalizations.of(context)!.motivationSentence48,
    AppLocalizations.of(context)!.motivationSentence49,
    AppLocalizations.of(context)!.motivationSentence50,
    AppLocalizations.of(context)!.motivationSentence51,
    AppLocalizations.of(context)!.motivationSentence52,
    AppLocalizations.of(context)!.motivationSentence53,
    AppLocalizations.of(context)!.motivationSentence54,
    AppLocalizations.of(context)!.motivationSentence55,
    AppLocalizations.of(context)!.motivationSentence56,
    AppLocalizations.of(context)!.motivationSentence57,
    AppLocalizations.of(context)!.motivationSentence58,
    AppLocalizations.of(context)!.motivationSentence59,
    AppLocalizations.of(context)!.motivationSentence60,
    AppLocalizations.of(context)!.motivationSentence61,
    AppLocalizations.of(context)!.motivationSentence62,
    AppLocalizations.of(context)!.motivationSentence63,
    AppLocalizations.of(context)!.motivationSentence64,
    AppLocalizations.of(context)!.motivationSentence65,
    AppLocalizations.of(context)!.motivationSentence66,
    AppLocalizations.of(context)!.motivationSentence67,
    AppLocalizations.of(context)!.motivationSentence68,
    AppLocalizations.of(context)!.motivationSentence69,
    AppLocalizations.of(context)!.motivationSentence70,
    AppLocalizations.of(context)!.motivationSentence71,
    AppLocalizations.of(context)!.motivationSentence72,
    AppLocalizations.of(context)!.motivationSentence73,
    AppLocalizations.of(context)!.motivationSentence74,
    AppLocalizations.of(context)!.motivationSentence75,
    AppLocalizations.of(context)!.motivationSentence76,
    AppLocalizations.of(context)!.motivationSentence77,
    AppLocalizations.of(context)!.motivationSentence78,
    AppLocalizations.of(context)!.motivationSentence79,
    AppLocalizations.of(context)!.motivationSentence80,
    AppLocalizations.of(context)!.motivationSentence81,
    AppLocalizations.of(context)!.motivationSentence82,
    AppLocalizations.of(context)!.motivationSentence83,
    AppLocalizations.of(context)!.motivationSentence84,
    AppLocalizations.of(context)!.motivationSentence85,
    AppLocalizations.of(context)!.motivationSentence86,
    AppLocalizations.of(context)!.motivationSentence87,
    AppLocalizations.of(context)!.motivationSentence88,
    AppLocalizations.of(context)!.motivationSentence89,
    AppLocalizations.of(context)!.motivationSentence90,
    AppLocalizations.of(context)!.motivationSentence91,
    AppLocalizations.of(context)!.motivationSentence92,
    AppLocalizations.of(context)!.motivationSentence93,
    AppLocalizations.of(context)!.motivationSentence94,
    AppLocalizations.of(context)!.motivationSentence95,
    AppLocalizations.of(context)!.motivationSentence96,
    AppLocalizations.of(context)!.motivationSentence97,
    AppLocalizations.of(context)!.motivationSentence98,
    AppLocalizations.of(context)!.motivationSentence99,
    AppLocalizations.of(context)!.motivationSentence100,
  ];

  final random = Random();
  return sentences[random.nextInt(sentences.length)];
}
