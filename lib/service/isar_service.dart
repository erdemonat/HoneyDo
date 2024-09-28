import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/model/pomodoro_model.dart' as pomodoro_model;
import 'package:honeydo/model/task_model.dart' as task_model;
import 'package:honeydo/model/volume_model.dart';
import 'package:honeydo/model/weather_model.dart';
import 'package:honeydo/model/window_model.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class IsarService {
  static Isar? _isar;
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
          WeatherDataSchema,
          WindowSettingsSchema,
          VolumeDataSchema,
        ],
        directory: dir.path,
      );
    }
    return _isar!;
  }

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

  Future<void> createOrUpdateTaskData(
      BuildContext context, String date, String taskName) async {
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
        ..markColor = ""
        ..isChecked = false;
      await isar.tasks.put(task);
      dateLink.tasks.add(task);
      await dateLink.tasks.save();
    });
    Provider.of<TasksMealsProvider>(context, listen: false)
        .loadUpcomingEvents();
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

  Future<void> createEmptyTaskDate(String date) async {
    final isar = await db;
    await isar.writeTxn(() async {
      task_model.HoneyDoData? honeyDoData = await getTaskDataByName();
      if (honeyDoData == null) {
        honeyDoData = task_model.HoneyDoData()..name = "HoneyDoData";
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
    });
  }

  Future<void> deleteMeal(int index, List<task_model.Meal> meals) async {
    final isar = await db;
    final meal = meals[index];
    await isar.writeTxn(() async {
      await meal.submeals.load();

      for (final subMeal in meal.submeals) {
        await isar.subMeals.delete(subMeal.id);
      }

      await isar.meals.delete(meal.id);
    });
  }

  Future<void> deleteTask(int index, List<task_model.Task> tasks) async {
    final isar = await db;
    final task = tasks[index];
    await isar.writeTxn(() async {
      await task.subtasks.load();

      for (final subTask in task.subtasks) {
        await isar.subTasks.delete(subTask.id);
      }

      await isar.tasks.delete(task.id);
    });
  }

  Future<void> updateMealOrderInDatabase(List<task_model.Meal> meals) async {
    final isar = await db;

    await isar.writeTxn(() async {
      for (int i = 0; i < meals.length; i++) {
        meals[i].order = i; // Sıralamayı güncelle
        await isar.meals.put(meals[i]);
      }
    });
  }

  Future<void> onReorderTask(
      BuildContext context, int oldIndex, int newIndex) async {
    TasksMealsProvider tasksMealsProvider =
        Provider.of<TasksMealsProvider>(context, listen: false);
    final isar = await db;

    await isar.writeTxn(() async {
      for (int i = 0; i < tasksMealsProvider.tasks.length; i++) {
        tasksMealsProvider.tasks[i].order = i;
        await isar.tasks.put(tasksMealsProvider.tasks[i]);
      }
    });
  }

  Future<void> addSubTask(task_model.Task tasks, task_model.SubTask subTask,
      String subtitleText) async {
    final isar = await db;
    await isar.writeTxn(() async {
      //subTask.task.value = tasks;
      await isar.subTasks.put(subTask);
      tasks.subtasks.add(subTask);
      await tasks.subtasks.save();
    });
  }

  Future<void> addSubMeal(task_model.Meal meals, task_model.SubMeal subMeal,
      String subtitleText) async {
    final isar = await db;
    await isar.writeTxn(() async {
      //subMeal.meal.value = meals;
      await isar.subMeals.put(subMeal);
      meals.submeals.add(subMeal);
      await meals.submeals.save();
    });
  }

  Future<void> deleteSubMealById(int mealId, int subMealId) async {
    final isar = await db;

    await isar.writeTxn(() async {
      final meal = await isar.meals.get(mealId);
      final subMeal = await isar.subMeals.get(subMealId);

      if (meal != null && subMeal != null) {
        await meal.submeals.load();
        meal.submeals.removeWhere((sm) => sm.id == subMealId);
        await meal.submeals.save();
        await isar.subMeals.delete(subMealId);
      }
    });
  }

  Future<void> deleteSubTaskById(int taskId, int subTaskId) async {
    final isar = await db;

    await isar.writeTxn(() async {
      final task = await isar.tasks.get(taskId);
      final subTask = await isar.subTasks.get(subTaskId);

      if (task != null && subTask != null) {
        await task.subtasks.load();
        task.subtasks.removeWhere((sm) => sm.id == subTaskId);
        await task.subtasks.save();
        await isar.subTasks.delete(subTaskId);
      }
    });
  }

  Future<void> updateTask(task_model.Task task) async {
    final isar = await db;

    await isar.writeTxn(() async {
      await isar.tasks.put(task);
    });
  }

  Future<void> updateTaskSub(task_model.Task task) async {
    final isar = await db;

    await isar.writeTxn(() async {
      if (task.isChecked) {
        await task.subtasks.load();

        for (var subTask in task.subtasks) {
          subTask.isChecked = true;
          await isar.subTasks.put(subTask);
        }
      }
      if (!task.isChecked) {
        await task.subtasks.load();

        for (var subTask in task.subtasks) {
          subTask.isChecked = false;
          await isar.subTasks.put(subTask);
        }
      }
    });
  }

  Future<void> updateSubtaskCheckedStatus(
      task_model.Task task, task_model.SubTask subTask) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.subTasks.put(subTask);
      await isar.tasks.put(task);
    });
  }

  Future<void> saveWeatherData(WeatherData weatherData) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.weatherDatas.put(weatherData);
    });
  }

  Future<String> getSavedCity() async {
    final isar = await db;
    final weatherData = await isar.weatherDatas.where().findFirst();
    return weatherData!.city;
  }

  Future<String> getSavedFormattedCity() async {
    final isar = await db;
    final weatherData = await isar.weatherDatas.where().findFirst();
    return weatherData!.formattedCity;
  }

  Future<void> saveWindowSizeAndPosition() async {
    final isar = await db;

    Size size = appWindow.size;
    Offset position = appWindow.position;

    final settings = WindowSettings(
      x: position.dx,
      y: position.dy,
      width: size.width,
      height: size.height,
    );

    await isar.writeTxn(() async {
      await isar.windowSettings.put(settings);
    });
  }

  Future<void> restoreWindowSizeAndPosition() async {
    final isar = await db;
    final settings = await isar.windowSettings.get(1);

    if (settings != null) {
      appWindow.size = Size(settings.width, settings.height);
      appWindow.position = Offset(settings.x, settings.y);
    }
  }

  Future<void> saveVolumeData(
      double currentProviderSoundValue, double currentSliderValue) async {
    final isar = await db;
    final volumeData = VolumeData()
      ..currentProviderSoundValue = currentProviderSoundValue
      ..currentSliderValue = currentSliderValue;

    await isar.writeTxn(() async {
      await isar.volumeDatas.put(volumeData);
    });
  }

  Future<VolumeData?> getVolumeData() async {
    final isar = await db;
    return await isar.volumeDatas.get(1);
  }
}
