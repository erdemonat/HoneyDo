import 'package:flutter/material.dart';

class FocusDateModel with ChangeNotifier {
  DateTime _focusDate = DateTime.now();

  DateTime get focusDate => _focusDate;

  void updateFocusDate(DateTime newDate) {
    _focusDate = newDate;
    notifyListeners();
  }
}
