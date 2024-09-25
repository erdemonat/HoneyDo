import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FocusDateProvider with ChangeNotifier {
  DateTime _focusDate = DateTime.now();
  final DateTime _now = DateTime.now();
  // DateTime _tomorrow = DateTime.now().add(Duration(days: 1));

  DateTime get focusDate => _focusDate;
  DateTime get now => _now;
  // DateTime get tomorrow => _tomorrow;

  void updateFocusDate(DateTime newDate) {
    _focusDate = newDate;
    notifyListeners();
  }

  String getFocusDate() {
    String formattedFocusDate = DateFormat('ddMMyyyy').format(_focusDate);
    return formattedFocusDate;
  }

  // String getTomorrowDate() {
  //   String formattedTomorrowDate = DateFormat('ddMMyyyy').format(_tomorrow);
  //   return formattedTomorrowDate;
  // }
}
