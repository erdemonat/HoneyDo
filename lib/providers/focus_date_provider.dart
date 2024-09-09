import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FocusDateProvider with ChangeNotifier {
  DateTime _focusDate = DateTime.now();

  DateTime get focusDate => _focusDate;

  void updateFocusDate(DateTime newDate) {
    _focusDate = newDate;
    notifyListeners();
  }

  String getFocusDate() {
    String formattedFocusDate = DateFormat('ddMMyyyy').format(_focusDate);
    return formattedFocusDate;
  }
}
