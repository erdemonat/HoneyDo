import 'package:isar/isar.dart';

part 'task_model.g.dart';

@collection
class TaskItem {
  Id id = Isar.autoIncrement;
  String taskName;

  TaskItem(this.taskName);
}

@collection
class TaskItems {
  Id id = Isar.autoIncrement;
  int taskDate;

  final taskItems = IsarLink<TaskItem>();

  TaskItems(this.taskDate);
}
