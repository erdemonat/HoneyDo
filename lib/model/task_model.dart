import 'package:isar/isar.dart';

part 'task_model.g.dart';

@Collection()
class TaskData {
  Id id = Isar.autoIncrement;

  late String name;

  final taskDates = IsarLinks<TaskDate>();
}

@Collection()
class TaskDate {
  Id id = Isar.autoIncrement;

  late String date;

  final tasks = IsarLinks<Task>();
}

@Collection()
class Task {
  Id id = Isar.autoIncrement;

  late String name;

  late int order;
}
