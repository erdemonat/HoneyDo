import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FocusDateProvider with ChangeNotifier {
  DateTime _focusDate = DateTime.now();
  final DateTime _now = DateTime.now();

  DateTime get focusDate => _focusDate;
  DateTime get now => _now;

  void updateFocusDate(DateTime newDate) {
    _focusDate = newDate;
    notifyListeners();
  }

  String getFocusDate() {
    String formattedFocusDate = DateFormat('ddMMyyyy').format(_focusDate);
    return formattedFocusDate;
  }

  String getTomorrowDate() {
    DateTime tomorrow = _focusDate.add(Duration(days: 1));
    String formattedTomorrowDate = DateFormat('ddMMyyyy').format(tomorrow);
    return formattedTomorrowDate;
  }
}
