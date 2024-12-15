import 'package:isar/isar.dart';

part 'pomodoro_model.g.dart';

@Collection()
class PomodoroSettings {
  Id id = 1;

  late int pomodoroDurationInSeconds;
  late int shortBreakDurationInSeconds;
  late int longBreakDurationInSeconds;

  late int setCount;
  late bool autoBreak;
  late bool autoPomodoro;

  @ignore
  Duration get pomodoroDuration => Duration(seconds: pomodoroDurationInSeconds);
  @ignore
  Duration get shortBreakDuration =>
      Duration(seconds: shortBreakDurationInSeconds);
  @ignore
  Duration get longBreakDuration =>
      Duration(seconds: longBreakDurationInSeconds);

  // Setter'lar
  void setPomodoroDuration(Duration duration) {
    pomodoroDurationInSeconds = duration.inSeconds;
  }

  void setShortBreakDuration(Duration duration) {
    shortBreakDurationInSeconds = duration.inSeconds;
  }

  void setLongBreakDuration(Duration duration) {
    longBreakDurationInSeconds = duration.inSeconds;
  }
}
