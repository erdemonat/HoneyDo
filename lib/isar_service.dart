import 'package:honeydo/model/pomodoro_model.dart' as pomodoro_model;
import 'package:honeydo/model/task_model.dart' as task_model;
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static Isar? _isar; // Singleton pattern için static bir örnek
  Future<Isar> get db async {
    if (_isar == null) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
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
    return _isar!;
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

  Future<task_model.HoneyDoData?> getTaskDataByName() async {
    final isar = await db;
    return await isar.honeyDoDatas
        .filter()
        .nameEqualTo("HoneyDoData")
        .findFirst();
  }

  Future<task_model.DateLinks?> getTaskDateByDate(
      task_model.HoneyDoData honeyDoData, String date) async {
    await honeyDoData.dateLinks.load();
    return honeyDoData.dateLinks.filter().dateEqualTo(date).findFirst();
  }

  Future<void> createOrUpdateTaskData(String date, String taskName) async {
    final isar = await db;
    const String dataName = "HoneyDoData";
    await isar.writeTxn(() async {
      task_model.HoneyDoData? honeyDoData = await getTaskDataByName();
      if (honeyDoData == null) {
        honeyDoData = task_model.HoneyDoData()..name = dataName;
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

  Future<void> createOrUpdateMealData(String date, String mealName) async {
    final isar = await db;
    const String dataName = "HoneyDoData";

    await isar.writeTxn(() async {
      task_model.HoneyDoData? honeyDoData = await getTaskDataByName();
      if (honeyDoData == null) {
        honeyDoData = task_model.HoneyDoData()..name = dataName;
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

  Future<void> deleteMeal(int index, List<task_model.Meal> meals) async {
    final isar = await db;
    final meal = meals[index];
    await isar.writeTxn(() async {
      await isar.meals.delete(meal.id);
    });
  }

  Future<void> deleteTask(int index, List<task_model.Task> tasks) async {
    final isar = await db;
    final task = tasks[index];
    await isar.writeTxn(() async {
      await isar.tasks.delete(task.id);
    });
  }
}
