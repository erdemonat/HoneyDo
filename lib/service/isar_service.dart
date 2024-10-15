import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:honeydo/providers/sync_card_provider.dart';
import 'package:honeydo/screens/auth.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/model/pomodoro_model.dart' as pomodoro_model;
import 'package:honeydo/model/task_model.dart' as task_model;
import 'package:honeydo/model/user_preferences_model.dart' as preference_model;
import 'package:honeydo/model/weather_model.dart';
import 'package:honeydo/model/window_model.dart';
import 'package:honeydo/providers/audio_player_provider.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
import 'package:honeydo/providers/weather_provider.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class IsarService {
  static Isar? _isar;
  Future<Isar> get db async {
    if (_isar == null) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        compactOnLaunch: const CompactCondition(minRatio: 1.5),
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
          preference_model.VolumeDataSchema,
          preference_model.ThemeDataSchema,
          preference_model.LanguageSchema,
        ],
        directory: dir.path,
      );
    }
    return _isar!;
  }

  Future<void> savePomodoroSettings(pomodoro_model.PomodoroSettings settings) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.pomodoroSettings.put(settings);
    });
  }

  Future<pomodoro_model.PomodoroSettings?> getPomodoroSettings() async {
    final isar = await db;
    return await isar.pomodoroSettings.get(1);
  }

  Future<List<task_model.HoneyDoData>> getAllHoneyDoData() async {
    final isar = await db;
    return await isar.honeyDoDatas.where().findAll();
  }

  Future<task_model.HoneyDoData?> getTaskDataByName() async {
    final isar = await db;
    return await isar.honeyDoDatas.filter().nameEqualTo("HoneyDoData").findFirst();
  }

  Future<task_model.DateLinks?> getTaskDateByDate(task_model.HoneyDoData honeyDoData, String date) async {
    await honeyDoData.dateLinks.load();
    return honeyDoData.dateLinks.filter().dateEqualTo(date).findFirst();
  }

  Future<void> createOrUpdateTaskData(BuildContext context, String date, String taskName) async {
    final isar = await db;
    const String dataName = "HoneyDoData";
    await isar.writeTxn(() async {
      task_model.HoneyDoData? honeyDoData = await getTaskDataByName();
      if (honeyDoData == null) {
        honeyDoData = task_model.HoneyDoData()..name = dataName;
        await isar.honeyDoDatas.put(honeyDoData);
      }
      task_model.DateLinks? dateLink = await getTaskDateByDate(honeyDoData, date);
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
    Provider.of<TasksMealsProvider>(context, listen: false).loadUpcomingEvents();
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
      task_model.DateLinks? dateLink = await getTaskDateByDate(honeyDoData, date);
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
      task_model.DateLinks? dateLink = await getTaskDateByDate(honeyDoData, date);
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
        meals[i].order = i;
        await isar.meals.put(meals[i]);
      }
    });
  }

  Future<void> onReorderTask(BuildContext context, int oldIndex, int newIndex) async {
    TasksMealsProvider tasksMealsProvider = Provider.of<TasksMealsProvider>(context, listen: false);
    final isar = await db;

    await isar.writeTxn(() async {
      for (int i = 0; i < tasksMealsProvider.tasks.length; i++) {
        tasksMealsProvider.tasks[i].order = i;
        await isar.tasks.put(tasksMealsProvider.tasks[i]);
      }
    });
  }

  Future<void> addSubTask(task_model.Task tasks, task_model.SubTask subTask, String subtitleText) async {
    final isar = await db;
    await isar.writeTxn(() async {
      //subTask.task.value = tasks;
      await isar.subTasks.put(subTask);
      tasks.subtasks.add(subTask);
      await tasks.subtasks.save();
    });
  }

  Future<void> addSubMeal(task_model.Meal meals, task_model.SubMeal subMeal, String subtitleText) async {
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

  Future<void> updateSubtaskCheckedStatus(task_model.Task task, task_model.SubTask subTask) async {
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

  Future<String> getSavedCity(BuildContext context) async {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    final isar = await db;
    final weatherData = await isar.weatherDatas.where().findFirst();
    if (weatherData == null) {
      final defaultWeatherData = WeatherData()
        ..city = weatherProvider.city
        ..formattedCity = weatherProvider.formattedCity
        ..iconCode = weatherProvider.iconCode
        ..temperature = weatherProvider.temperature
        ..weatherStatus = weatherProvider.weatherStatus;
      await isar.writeTxn(() async {
        isar.weatherDatas.put(defaultWeatherData);
      });

      return defaultWeatherData.city;
    }
    return weatherData.city;
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appWindow.size = Size(settings.width, settings.height);
        appWindow.position = Offset(settings.x, settings.y);
      });
    }
  }

  Future<void> saveVolumeData(BuildContext context, double currentVolume) async {
    final soundProvider = Provider.of<SoundEffectProvider>(context, listen: false);
    final isar = await db;
    final volumeData = preference_model.VolumeData()..currentVolume = soundProvider.currentVolume;

    await isar.writeTxn(() async {
      await isar.volumeDatas.put(volumeData);
    });
  }

  Future<preference_model.VolumeData?> getVolumeData() async {
    final isar = await db;
    var volumeData = await isar.volumeDatas.get(1);

    if (volumeData == null) {
      final defaultVolumeData = preference_model.VolumeData()..currentVolume = 0.5;

      await isar.writeTxn(() async {
        await isar.volumeDatas.put(defaultVolumeData);
      });

      return defaultVolumeData;
    }

    return volumeData;
  }

  Future<void> saveThemeData(int currentThemeIndex, bool isDarkMode) async {
    final isar = await db;
    final themeData = preference_model.ThemeData()
      ..currentThemeIndex = currentThemeIndex
      ..isDarkMode = isDarkMode;

    await isar.writeTxn(() async {
      await isar.themeDatas.put(themeData);
    });
  }

  Future<preference_model.ThemeData?> getThemeData() async {
    final isar = await db;

    var themeData = await isar.themeDatas.get(2);

    if (themeData == null) {
      final defaultThemeData = preference_model.ThemeData()
        ..currentThemeIndex = 1
        ..isDarkMode = true;

      await isar.writeTxn(() async {
        await isar.themeDatas.put(defaultThemeData);
      });

      return defaultThemeData;
    }

    return themeData;
  }

  Future<void> createBackUp() async {
    final isar = await db;

    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'HoneyDo Verilerini Dışa Aktar',
      fileName: 'honeydo_backup.isar',
    );

    if (outputFile != null) {
      final File backupFile = File(outputFile);
      if (await backupFile.exists()) {
        await backupFile.delete();
      }
      await isar.copyToFile(outputFile);
    }
  }

  Future<void> downloadDataToDevice() async {
    await createCloudBackUp(
      (bytesTransferred, totalBytes) {},
    );
    await createBackUp();
  }

  Future<void> createCloudBackUp(Function(double bytesTransferred, double totalBytes) onProgress) async {
    final isar = await db;
    var currentUserUID = auth.currentUser!.uid;

    DateTime localTimeNow = DateTime.now();
    String localFormattedDate = DateFormat('dd-MM-yyyy HH:mm').format(localTimeNow);

    var fileName = "$currentUserUID.isar";
    var storageRef = FirebaseStorage.instance.ref().child(currentUserUID).child(fileName);

    SettableMetadata metadata = SettableMetadata(
      customMetadata: {
        'uploadDateLocal': localFormattedDate,
      },
    );

    // Get the application documents directory
    final appDocDir = await getApplicationDocumentsDirectory();

    // Create a backup file path
    String backupPath = '${appDocDir.path}/$currentUserUID.isar';

    // Create a File instance for the backup file
    final File backupFile = File(backupPath);

    // Check if the backup file exists; if so, delete it
    if (await backupFile.exists()) {
      await backupFile.delete();
    }

    // Copy the database to the backup file
    await isar.copyToFile(backupPath);

    // Now upload the file to Firebase Storage
    final uploadTask = storageRef.putFile(backupFile, metadata);

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      double bytesTransferred = snapshot.bytesTransferred / (1024 * 1024);
      double totalBytes = snapshot.totalBytes / (1024 * 1024);

      onProgress(bytesTransferred, totalBytes);
    });

    await uploadTask;
  }

  Future<void> restoreDBOnCloud() async {
    final isar = await db;
    var currentUserUID = auth.currentUser!.uid;

    var fileName = "$currentUserUID.isar";
    var storageRef = FirebaseStorage.instance.ref().child(currentUserUID).child(fileName);

    // Firebase Storage'den veriyi indiriyoruz
    Uint8List? fileData = await storageRef.getData();

    if (fileData != null) {
      // Geçici dosya yolu oluşturuluyor
      final tempDir = await getTemporaryDirectory();
      final tempFilePath = p.join(tempDir.path, fileName);
      final backupFile = File(tempFilePath);

      // İndirilen veriyi geçici dosyaya yazıyoruz
      await backupFile.writeAsBytes(fileData);

      // Eğer geçici dosya gerçekten varsa
      if (await backupFile.exists()) {
        final dbDirectory = await getApplicationDocumentsDirectory();
        final dbPath = p.join(dbDirectory.path, 'default.isar');

        // Veritabanı kapatılmadan önce verileri belleğe alıyoruz
        final weatherSchema = await isar.weatherDatas.get(2);
        final windowSchema = await isar.windowSettings.get(1);
        final volumeSchema = await isar.volumeDatas.get(1);
        final themeSchema = await isar.themeDatas.get(2);

        // Eğer veritabanı açıksa kapatıyoruz
        if (isar.isOpen) {
          await isar.close();
        }

        // Hedefte var olan dosyayı kontrol ediyoruz
        final existingDbFile = File(dbPath);
        if (await existingDbFile.exists()) {
          // Dosya varsa siliyoruz
          await existingDbFile.delete();
        }

        // Geçici dosyayı veritabanı dosyasına kopyalıyoruz
        await backupFile.copy(dbPath);

        // Veritabanını yeniden açıyoruz
        final reopenedIsar = await Isar.open(
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
            preference_model.VolumeDataSchema,
            preference_model.ThemeDataSchema,
            preference_model.LanguageSchema,
          ],
          directory: dbDirectory.path,
        );

        // Verileri geri yüklüyoruz
        await reopenedIsar.writeTxn(
          () async {
            if (weatherSchema != null) {
              await reopenedIsar.weatherDatas.put(weatherSchema);
            }
            if (windowSchema != null) {
              await reopenedIsar.windowSettings.put(windowSchema);
            }
            if (volumeSchema != null) {
              await reopenedIsar.volumeDatas.put(volumeSchema);
            }
            if (themeSchema != null) {
              await reopenedIsar.themeDatas.put(themeSchema);
            }
          },
        );

        await _restartApp();
      }
    } else {}
  }

  Future<void> restoreDB() async {
    final isar = await db;

    final weatherSchema = await isar.weatherDatas.get(2);

    final windowSchema = await isar.windowSettings.get(1);

    final volumeSchema = await isar.volumeDatas.get(1);
    final themeSchema = await isar.themeDatas.get(2);

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'HoneyDo Verilerini İçe Aktar',
      type: FileType.custom,
      allowedExtensions: [
        'isar'
      ],
    );

    if (result != null) {
      String filePath = result.files.single.path!;
      final backupFile = File(filePath);

      if (await backupFile.exists()) {
        final dbDirectory = await getApplicationDocumentsDirectory();
        final dbPath = p.join(dbDirectory.path, 'default.isar');

        if (!isar.isOpen) {
          print('Veritabanı zaten kapalı');
          return;
        }
        await isar.close();

        await backupFile.copy(dbPath);

        final reopenedIsar = await Isar.open(
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
            preference_model.VolumeDataSchema,
            preference_model.ThemeDataSchema,
            preference_model.LanguageSchema,
          ],
          directory: dbDirectory.path,
        );

        await reopenedIsar.writeTxn(
          () async {
            if (weatherSchema != null) {
              await reopenedIsar.weatherDatas.put(weatherSchema);
            }
            if (windowSchema != null) {
              await reopenedIsar.windowSettings.put(windowSchema);
            }
            if (volumeSchema != null) {
              await reopenedIsar.volumeDatas.put(volumeSchema);
            }
            if (themeSchema != null) {
              await reopenedIsar.themeDatas.put(themeSchema);
            }
          },
        );

        await _restartApp();
      }
    }
  }

  Future<void> _restartApp() async {
    final executable = Platform.resolvedExecutable;
    final script = Platform.script.toFilePath();
    final workingDirectory = p.dirname(script);

    await Process.start(executable, [], workingDirectory: workingDirectory);
    exit(0);
  }

  Future<void> saveLanguage(index) async {
    final isar = await db;
    final language = preference_model.Language()..languageIndex = index;

    await isar.writeTxn(() async {
      await isar.languages.put(language);
    });
  }

  Future<Object> getLanguage() async {
    final isar = await db;

    var language = await isar.languages.get(3);

    if (language == null) {
      final defaultLanguage = preference_model.Language()..languageIndex = 1;

      await isar.writeTxn(() async {
        await isar.languages.put(defaultLanguage);
      });

      return defaultLanguage.languageIndex;
    }

    return language.languageIndex;
  }
}
