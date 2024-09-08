import 'package:honeydo/main.dart';
import 'package:honeydo/model/pomodoro_model.dart' as pomodoro_model;
import 'package:honeydo/model/task_model.dart' as task_model;
import 'package:honeydo/screens/todo_tasks_card.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = _initDB();
  }

  Future<Isar> _initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [
        pomodoro_model.PomodoroSettingsSchema,
        task_model.HoneyDoDataSchema,
        task_model.DateLinksSchema,
        task_model.TaskSchema,
        task_model.SubTaskSchema,
        task_model.MealSchema,
        task_model.SubMealSchema,
      ],
      directory: dir.path,
    );
  }

  // Pomodoro ayarlarını kaydetmek veya güncellemek için
  Future<void> savePomodoroSettings(
      pomodoro_model.PomodoroSettings settings) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.pomodoroSettings.put(settings);
    });
  }

  // Pomodoro ayarlarını çekmek için
  Future<pomodoro_model.PomodoroSettings?> getPomodoroSettings() async {
    final isar = await db;
    return await isar.pomodoroSettings.get(1);
  }

  Future<List<task_model.HoneyDoData>> getAllHoneyDoData() async {
    final isar = await db;
    return await isar.honeyDoDatas
        .where()
        .findAll(); // HoneyDoDatas'a erişim sağlama
  }

  Future<task_model.HoneyDoData?> getTaskDataByName(String name) async {
    final isar = await db;
    return await isar.honeyDoDatas
        .filter()
        .nameEqualTo(name)
        .findFirst(); // Filtreleme işlemi
  }

  Future<task_model.DateLinks?> getTaskDateByDate(
      task_model.HoneyDoData honeyDoData, String date) async {
    await honeyDoData.dateLinks.load();
    return honeyDoData.dateLinks.filter().dateEqualTo(date).findFirst();
  }

  Future<void> createOrUpdateTaskData(
      String taskDataName, String date, String taskName) async {
    final isar = await db;
    await isar.writeTxn(() async {
      task_model.HoneyDoData? honeyDoData =
          await getTaskDataByName(taskDataName);
      if (honeyDoData == null) {
        honeyDoData = task_model.HoneyDoData()..name = taskDataName;
        await isar.honeyDoDatas.put(honeyDoData);
      }
      task_model.DateLinks? dateLink =
          await getTaskDateByDate(honeyDoData, date);
      if (dateLink == null) {
        dateLink = task_model.DateLinks()..date = date;
        await isar.dateLinks.put(dateLink);
        honeyDoData.dateLinks.add(dateLink);
        await honeyDoData.dateLinks.save();
      }
      await dateLink.tasks.load();
      int nextOrder = dateLink.tasks.length;

      final task = task_model.Task()
        ..name = taskName
        ..order = nextOrder
        ..isMarked = false
        ..markColor = "4294198070"
        ..isChecked = false;
      await isar.tasks.put(task);
      dateLink.tasks.add(task);
      await dateLink.tasks.save();
    });
  }

  Future<void> createOrUpdateMealData(
      String mealDataName, String date, String mealName) async {
    final isar = await db;
    await isar.writeTxn(() async {
      task_model.HoneyDoData? honeyDoData =
          await getTaskDataByName(mealDataName);
      if (honeyDoData == null) {
        honeyDoData = task_model.HoneyDoData()..name = mealDataName;
        await isar.honeyDoDatas.put(honeyDoData);
      }
      task_model.DateLinks? dateLink =
          await getTaskDateByDate(honeyDoData, date);
      if (dateLink == null) {
        dateLink = task_model.DateLinks()..date = date;
        await isar.dateLinks.put(dateLink);
        honeyDoData.dateLinks.add(dateLink);
        await honeyDoData.dateLinks.save();
      }
      await dateLink.meals.load();
      int nextOrder = dateLink.meals.length;

      final meal = task_model.Meal()
        ..name = mealName
        ..order = nextOrder;
      await isar.meals.put(meal);
      dateLink.meals.add(meal);
      await dateLink.meals.save();
    });
  }

  // Future<void> onReorderMeal(int oldIndex, int newIndex) async {
  //   final isar = await db;

  //   if (newIndex > oldIndex) {
  //     newIndex -= 1;
  //   }
  //   final task_model.Meal item = meals.removeAt(oldIndex);
  //   meals.insert(newIndex, item);

  //   await isar.writeTxn(() async {
  //     for (int i = 0; i < meals.length; i++) {
  //       meals[i].order = i;
  //       await isar.meals.put(meals[i]);
  //     }
  //   });
  // }

  // Future<void> _onReorderTask(int oldIndex, int newIndex) async {
  //   setState(() {
  //     if (newIndex > oldIndex) {
  //       newIndex -= 1;
  //     }
  //     final Task item = tasks.removeAt(oldIndex);
  //     tasks.insert(newIndex, item);
  //   });

  //   await isar.writeTxn(() async {
  //     for (int i = 0; i < tasks.length; i++) {
  //       tasks[i].order = i;
  //       await isar.tasks.put(tasks[i]);
  //     }
  //   });
  // }

  //  Future<void> _deleteTask(int index) async {
  //   final task = tasks[index];
  //   await isar.writeTxn(() async {
  //     await isar.tasks.delete(task.id);
  //   });
  //   setState(() {
  //     tasks.removeAt(index);
  //   });
  // }

  // Future<void> _deleteMeal(int index) async {
  //   final meal = meals[index];
  //   await isar.writeTxn(() async {
  //     await isar.meals.delete(meal.id);
  //   });
  //   setState(() {
  //     meals.removeAt(index);
  //   });
  // }

  // Future<void> _updateTaskCheckedStatus(bool? value) async {
  //   final isar = isarService.db;
  //   final isChecked = value ?? false;

  //   setState(() {
  //     widget.task.isChecked = isChecked;
  //   });

  //   await isar.writeTxn(() async {
  //     if (isChecked) {
  //       await widget.task.subtasks.load();
  //       for (final subtask in widget.task.subtasks) {
  //         subtask.isChecked = true;
  //         await isar.subTasks.put(subtask);
  //       }
  //     }
  //     await isar.tasks.put(widget.task);
  //   });

  //   widget.onTaskChecked(isChecked);
  // }
}
