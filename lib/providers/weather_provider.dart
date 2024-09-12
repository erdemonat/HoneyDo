import 'package:flutter/material.dart';
import 'package:honeydo/isar_service.dart';

class WeatherProvider with ChangeNotifier {
  final IsarService _isarService = IsarService();

  String _city = "Istanbul";
  String _weatherStatus = "Güneşli";
  int _temperature = 30;
  int _wind = 20;
  int _humidity = 19;
  int _precipitation = 15;

  String get city => _city;
  String get weatherStatus => _weatherStatus;
  int get temperature => _temperature;
  int get wind => _temperature;
  int get humidity => _temperature;
  int get precipitation => _precipitation;
}

// Future<void> _saveCityWeather() async {
//   PomodoroSettings settings = PomodoroSettings()
//     ..setPomodoroDuration(_pomodoroDuration)
//     ..setShortBreakDuration(_shortBreakDuration)
//     ..setLongBreakDuration(_longBreakDuration)
//     ..setCount = _setCount
//     ..autoBreak = _autoBreak
//     ..autoPomodoro = _autoPomodoro;

//   await _isarService.savePomodoroSettings(settings);
// }
