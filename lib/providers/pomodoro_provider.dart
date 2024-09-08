import 'package:flutter/material.dart';
import 'package:honeydo/isar_service.dart';
import 'package:honeydo/model/pomodoro_model.dart';

class PomodoroProvider with ChangeNotifier {
  final IsarService _isarService = IsarService();

  Duration _pomodoroDuration = const Duration(minutes: 25);
  Duration _shortBreakDuration = const Duration(minutes: 5);
  Duration _longBreakDuration = const Duration(minutes: 15);
  int _setCount = 4;
  bool _autoBreak = false;
  bool _autoPomodoro = false;

  Duration get pomodoroDuration => _pomodoroDuration;
  Duration get shortBreakDuration => _shortBreakDuration;
  Duration get longBreakDuration => _longBreakDuration;
  int get setCount => _setCount;
  bool get autoBreak => _autoBreak;
  bool get autoPomodoro => _autoPomodoro;

  PomodoroProvider() {
    _loadPomodoroSettings();
  }

  void _loadPomodoroSettings() async {
    PomodoroSettings? settings = await _isarService.getPomodoroSettings();
    if (settings != null) {
      _pomodoroDuration = settings.pomodoroDuration;
      _shortBreakDuration = settings.shortBreakDuration;
      _longBreakDuration = settings.longBreakDuration;
      _setCount = settings.setCount;
      _autoBreak = settings.autoBreak;
      _autoPomodoro = settings.autoPomodoro;
      notifyListeners();
    }
  }

  Future<void> _savePomodoroSettings() async {
    PomodoroSettings settings = PomodoroSettings()
      ..setPomodoroDuration(_pomodoroDuration)
      ..setShortBreakDuration(_shortBreakDuration)
      ..setLongBreakDuration(_longBreakDuration)
      ..setCount = _setCount
      ..autoBreak = _autoBreak
      ..autoPomodoro = _autoPomodoro;

    await _isarService.savePomodoroSettings(settings);
  }

  void setAllPomodoroSettings(Duration pomodoro, Duration shortBreak,
      Duration longBreak, int setCount, bool autoBreak, bool autoPomodoro) {
    _pomodoroDuration = pomodoro;
    _shortBreakDuration = shortBreak;
    _longBreakDuration = longBreak;
    _setCount = setCount;
    _autoBreak = autoBreak;
    _autoPomodoro = autoPomodoro;
    notifyListeners();
    _savePomodoroSettings();
  }

  void setPomodoroDuration(Duration value) {
    _pomodoroDuration = value;
    notifyListeners();
    _savePomodoroSettings();
  }

  void setShortBreakDuration(Duration value) {
    _shortBreakDuration = value;
    notifyListeners();
    _savePomodoroSettings();
  }

  void setLongBreakDuration(Duration value) {
    _longBreakDuration = value;
    notifyListeners();
    _savePomodoroSettings();
  }

  void setCountValue(int value) {
    _setCount = value;
    notifyListeners();
    _savePomodoroSettings();
  }

  void isAutoBreak(bool value) {
    _autoBreak = value;
    notifyListeners();
    _savePomodoroSettings();
  }

  void isAutopomodoro(bool value) {
    _autoPomodoro = value;
    notifyListeners();
    _savePomodoroSettings();
  }
}
