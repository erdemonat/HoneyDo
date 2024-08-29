import 'package:flutter/material.dart';

TextStyle cardTitleTextStyle(BuildContext context) {
  return const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}

TextStyle cardSubTitleTextStyle(BuildContext context) {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: Colors.white,
  );
}

TextStyle calendarDayNumberTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.tertiary,
  );
}

TextStyle calendarDayTextStyle(BuildContext context) {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
