import 'package:flutter/material.dart';

TextStyle kCardTitleTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}

TextStyle kCardSubTitleTextStyle(BuildContext context) {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  );
}

TextStyle kCalendarDayNumberTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.tertiary,
  );
}

TextStyle kCalendarDayTextStyle(BuildContext context) {
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.tertiary,
  );
}

TextStyle kPomodoroSettingsTextStyle(BuildContext context) {
  // Metin boyutunu ekrana göre ayarlama

  return TextStyle(
    color: Theme.of(context).colorScheme.tertiary,
    fontSize: 14,
    // fontFeatures: const [FontFeature.enable('smcp')],
  );
}

TextStyle kCalendarMonthYearTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Theme.of(context).colorScheme.tertiary,
    //letterSpacing: 1.2,
    // shadows: [
    //   Shadow(
    //     offset: const Offset(2.0, 2.0),
    //     blurRadius: 4.0,
    //     color: Colors.white.withOpacity(0.3),
    //   ),
    // ],
  );
}

TextStyle kPomodoroStatusTextStyle(BuildContext context) {
  // Metin boyutunu ekrana göre ayarlama

  return TextStyle(color: Theme.of(context).colorScheme.tertiary, fontSize: 18, fontWeight: FontWeight.bold
      // fontFeatures: const [FontFeature.enable('smcp')],
      );
}
