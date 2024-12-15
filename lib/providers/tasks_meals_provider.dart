import 'dart:math';

import 'package:flutter/material.dart';
import 'package:honeydo/providers/audio_player_provider.dart';
import 'package:honeydo/providers/language_provider.dart';
import 'package:honeydo/service/isar_service.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/subtitle_model.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:honeydo/providers/focus_date_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TasksMealsProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Meal> _meals = [];

  List<String> _upcomingEvents = [];

  Map<int, List<SubtitleItem>> _subMeals = {};
  Map<int, List<SubtitleItem>> _subTasks = {};

  List<Task> get tasks => _tasks;
  List<Meal> get meals => _meals;
  List<String> get upcomingEvents => _upcomingEvents;

  Future<void> createEmptyTaskDate(BuildContext context, String date) async {
    await isarService.createEmptyTaskDate(date);
    await loadTasks(context);
    await loadMeals(context);
    notifyListeners();
  }

  int completedSubTaskCount(int taskId) {
    List<SubtitleItem> subtasks = _subTasks[taskId] ?? [];

    int completedCount = subtasks.where((st) => st.isChecked).length;

    if (subtasks.isEmpty) {
      return 0;
    }

    return completedCount;
  }

  Future<void> loadUpcomingEvents() async {
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(const Duration(days: 1));
    DateTime dayAfterTomorrow = today.add(const Duration(days: 2));
    DateTime twoDaysAfterTomorrow = today.add(const Duration(days: 3));
    String tomorrowDay = DateFormat('EEEE', LanguageProvider().getLanguageCode()).format(tomorrow);
    String dayAfterTomorrowDay = DateFormat('EEEE', LanguageProvider().getLanguageCode()).format(dayAfterTomorrow);
    String twoDaysAfterTomorrowDay = DateFormat('EEEE', LanguageProvider().getLanguageCode()).format(twoDaysAfterTomorrow);

    String formattedTomorrowDate = DateFormat('ddMMyyyy').format(tomorrow);
    String formattedDayAfterTomorrowDate = DateFormat('ddMMyyyy').format(dayAfterTomorrow);
    String formattedTwoDaysAfterTomorrowDate = DateFormat('ddMMyyyy').format(twoDaysAfterTomorrow);

    HoneyDoData? honeyDoData = await isarService.getTaskDataByName();
    if (honeyDoData != null) {
      DateLinks? taskDateObjTomorrow = await isarService.getTaskDateByDate(honeyDoData, formattedTomorrowDate);
      if (taskDateObjTomorrow != null) {
        await taskDateObjTomorrow.tasks.load();
      }

      DateLinks? taskDateObjDayAfterTomorrow = await isarService.getTaskDateByDate(honeyDoData, formattedDayAfterTomorrowDate);
      if (taskDateObjDayAfterTomorrow != null) {
        await taskDateObjDayAfterTomorrow.tasks.load();
      }

      DateLinks? taskDateObjTwoDaysAfterTomorrow = await isarService.getTaskDateByDate(honeyDoData, formattedTwoDaysAfterTomorrowDate);
      if (taskDateObjTwoDaysAfterTomorrow != null) {
        await taskDateObjTwoDaysAfterTomorrow.tasks.load();
      }

      _upcomingEvents = [
        ...?taskDateObjTomorrow?.tasks.where((task) => task.markColor == "4294198070").map((task) => '$tomorrowDay: ${task.name}').toList(),
        ...?taskDateObjDayAfterTomorrow?.tasks.where((task) => task.markColor == "4294198070").map((task) => '$dayAfterTomorrowDay: ${task.name}').toList(),
        ...?taskDateObjTwoDaysAfterTomorrow?.tasks.where((task) => task.markColor == "4294198070").map((task) => '$twoDaysAfterTomorrowDay: ${task.name}').toList(),
      ];
    }
    notifyListeners();
  }

  double completedSubtasksPercentage(int taskId) {
    List<SubtitleItem> subtasks = _subTasks[taskId] ?? [];

    int completedCount = subtasks.where((st) => st.isChecked).length;

    if (subtasks.isEmpty) {
      return 0;
    }

    double percentage = (completedCount / subtasks.length) * 100;
    return percentage;
  }

  Future<void> loadTasks(BuildContext context) async {
    String taskDate = Provider.of<FocusDateProvider>(context, listen: false).getFocusDate();

    HoneyDoData? honeyDoData = await isarService.getTaskDataByName();
    if (honeyDoData != null) {
      DateLinks? taskDateObj = await isarService.getTaskDateByDate(honeyDoData, taskDate);
      if (taskDateObj != null) {
        await taskDateObj.tasks.load();
        _tasks = taskDateObj.tasks.toList()..sort((a, b) => a.order.compareTo(b.order));
      }
    }
    notifyListeners();
  }

  Future<void> loadMeals(BuildContext context) async {
    String mealDate = Provider.of<FocusDateProvider>(context, listen: false).getFocusDate();

    HoneyDoData? honeyDoData = await isarService.getTaskDataByName();
    if (honeyDoData != null) {
      DateLinks? mealDateObj = await isarService.getTaskDateByDate(honeyDoData, mealDate);
      if (mealDateObj != null) {
        await mealDateObj.meals.load();
        _meals = mealDateObj.meals.toList()..sort((a, b) => a.order.compareTo(b.order));
      }
    }

    notifyListeners();
  }

  Future<void> shiftTaskDate(BuildContext context, int index) async {
    await isarService.shiftTaskDate(index, _tasks, context);
    _tasks.removeAt(index);
    loadUpcomingEvents();
    Provider.of<SoundEffectProvider>(context, listen: false).playSound('infoPop2');
    notifyListeners();
  }

  void removeTask(BuildContext context, int index) async {
    await isarService.deleteTask(index, _tasks);
    _tasks.removeAt(index);
    loadUpcomingEvents();
    Provider.of<SoundEffectProvider>(context, listen: false).playSound('infoPop1');
    notifyListeners();
  }

  void removeMeal(BuildContext context, int index) async {
    await isarService.deleteMeal(index, _meals);
    _meals.removeAt(index);
    Provider.of<SoundEffectProvider>(context, listen: false).playSound('infoPop1');
    notifyListeners();
  }

  Future<void> onReorderMeal(BuildContext context, int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final Meal item = _meals.removeAt(oldIndex);
    _meals.insert(newIndex, item);

    await IsarService().updateMealOrderInDatabase(_meals);
    loadMeals(context);

    notifyListeners();
  }

  Future<void> onReorderTask(BuildContext context, int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final Task item = _tasks.removeAt(oldIndex);
    _tasks.insert(newIndex, item);

    await IsarService().onReorderTask(context, oldIndex, newIndex);

    notifyListeners();
  }

  Future<void> addSubTask(Task tasks, String subtitleText) async {
    final subTask = SubTask()
      ..name = subtitleText
      ..isChecked = false;

    await isarService.addSubTask(tasks, subTask, subtitleText);
    uncheckTaskOnSubtaskAdd(tasks);
    notifyListeners();
  }

  Future<void> addSubMeal(Meal meals, String subtitleText) async {
    final subMeal = SubMeal()..name = subtitleText;

    await isarService.addSubMeal(meals, subMeal, subtitleText);

    notifyListeners();
  }

  Future<void> deleteSubMeal(int mealId, String subtitleText) async {
    final meal = _meals.firstWhere((meal) => meal.id == mealId);

    final subMeal = meal.submeals.firstWhere((sm) => sm.name == subtitleText);

    await isarService.deleteSubMealById(meal.id, subMeal.id);

    meal.submeals.remove(subMeal);

    notifyListeners();
  }

  Future<void> deleteSubTask(int taskId, String subtitleText) async {
    final task = _tasks.firstWhere((task) => task.id == taskId);

    final subTask = task.subtasks.firstWhere((sm) => sm.name == subtitleText);

    await isarService.deleteSubTaskById(task.id, subTask.id);

    task.subtasks.remove(subTask);

    notifyListeners();
  }

  //

  List<SubtitleItem> getSubMeals(int mealId) {
    return _subMeals[mealId] ?? [];
  }

  //

  Future<void> loadSubMeals(Meal meal) async {
    await meal.submeals.load();

    List<SubtitleItem> subtitles = [];
    for (final subMeal in meal.submeals) {
      subtitles.add(SubtitleItem(id: subMeal.id, text: subMeal.name));
    }

    _subMeals[meal.id] = subtitles;
    notifyListeners();
  }

  List<SubtitleItem> getSubTask(int taskId) {
    return _subTasks[taskId] ?? [];
  }

  Future<void> loadSubTasks(Task task) async {
    await task.subtasks.load();

    List<SubtitleItem> subtitles = [];
    for (final subTask in task.subtasks) {
      if (!subTask.isChecked) subtitles.add(SubtitleItem(id: subTask.id, text: subTask.name, isChecked: subTask.isChecked));
    }
    for (final subTask in task.subtasks) {
      if (subTask.isChecked) subtitles.add(SubtitleItem(id: subTask.id, text: subTask.name, isChecked: subTask.isChecked));
    }

    _subTasks[task.id] = subtitles;
    notifyListeners();
  }

  Future<void> updateTaskMarkStatus(Task task, String color, bool isMarked) async {
    task.markColor = color;
    task.isMarked = isMarked;
    await isarService.updateTask(task);
    loadUpcomingEvents();
    notifyListeners();
  }

  Future<void> updateSubtaskCheckedStatus(int taskId, int subTaskId, bool isChecked, BuildContext context) async {
    Task task = _tasks.firstWhere((t) => t.id == taskId);
    final SoundEffectProvider soundEffectProvider = Provider.of<SoundEffectProvider>(context, listen: false);

    SubTask subTask = task.subtasks.firstWhere((st) => st.id == subTaskId);

    subTask.isChecked = isChecked;

    await isarService.updateSubtaskCheckedStatus(task, subTask);

    bool allChecked = task.subtasks.every((st) => st.isChecked);
    if (allChecked) {
      final random = Random();
      int randomNumber = 1 + random.nextInt(26);
      soundEffectProvider.playSound('marimbaWin$randomNumber');

      task.isChecked = true;

      await isarService.updateTask(task);
    }
    if (!allChecked) {
      task.isChecked = false;
      await isarService.updateTask(task);
    }
    if (isChecked && !allChecked) {
      soundEffectProvider.playSound("multiPop2");
    }
    Future.delayed(Durations.extralong4);
    loadSubTasks(task);
    notifyListeners();
  }

  Future<void> updateTaskCheckedStatus(Task tasks) async {
    tasks.isChecked = !tasks.isChecked;
    await isarService.updateTask(tasks);
    await isarService.updateTaskSub(tasks);
    await loadSubTasks(tasks);
    notifyListeners();
  }

  Future<void> uncheckTaskOnSubtaskAdd(Task tasks) async {
    tasks.isChecked = false;
    await isarService.updateTask(tasks);
    notifyListeners();
  }
}
