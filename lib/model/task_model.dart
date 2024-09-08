import 'package:isar/isar.dart';

part 'task_model.g.dart';

@Collection()
class HoneyDoData {
  Id id = Isar.autoIncrement;

  late String name;

  final dateLinks = IsarLinks<DateLinks>();
}

@Collection()
class DateLinks {
  Id id = Isar.autoIncrement;

  late String date;

  final tasks = IsarLinks<Task>();

  final meals = IsarLinks<Meal>();
}

@Collection()
class Meal {
  Id id = Isar.autoIncrement;

  late String name;

  late int order;

  final submeals = IsarLinks<SubMeal>();
}

@Collection()
class SubMeal {
  Id id = Isar.autoIncrement;

  late String name;

  final meal = IsarLink<Meal>();
}

@Collection()
class Task {
  Id id = Isar.autoIncrement;

  late String name;

  late String markColor;

  late int order;

  late bool isChecked;

  late bool isMarked;

  final subtasks = IsarLinks<SubTask>();
}

@Collection()
class SubTask {
  Id id = Isar.autoIncrement;

  late String name;

  late bool isChecked;

  final task = IsarLink<Task>();
}

@Collection()
class PomodoroSettings {
  Id id = 1;

  late int pomodoroDuration;

  late int shortBreakDuration;

  late int longBreakDuration;

  late int setCount;

  late bool autoBreak;

  late bool autoPomodoro;
}
