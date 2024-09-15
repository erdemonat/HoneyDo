import 'package:flutter/material.dart';
import 'package:honeydo/isar_service.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/subtitle_model.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:honeydo/providers/focus_date_provider.dart';
import 'package:provider/provider.dart';

class TasksMealsProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Meal> _meals = [];

  Map<int, List<SubtitleItem>> _subMeals = {};
  Map<int, List<SubtitleItem>> _subTasks = {};

  List<Task> get tasks => _tasks;
  List<Meal> get meals => _meals;

  Future<void> createEmptyTaskDate(BuildContext context, String date) async {
    await isarService.createEmptyTaskDate(date);
    await loadTasks(context);
    await loadMeals(context);
    notifyListeners();
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

  void removeTask(BuildContext context, int index) async {
    await IsarService().deleteTask(index, _tasks);
    _tasks.removeAt(index);
    notifyListeners();
  }

  void removeMeal(BuildContext context, int index) async {
    await IsarService().deleteMeal(index, _meals);
    _meals.removeAt(index);
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

    notifyListeners();
  }

  Future<void> addSubMeal(Meal meals, String subtitleText) async {
    final subMeal = SubMeal()..name = subtitleText;

    await isarService.addSubMeal(meals, subMeal, subtitleText);

    notifyListeners();
  }

  Future<void> updateSubtitleCheckStatus(Task task, String subtitleText, bool isChecked) async {
    final subTask = task.subtasks.where((st) => st.name == subtitleText).first;

    subTask.isChecked = isChecked;

    await isarService.updateSubtitleCheckStatus(task, subTask);

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
      subtitles.add(SubtitleItem(text: subMeal.name));
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
      subtitles.add(SubtitleItem(text: subTask.name, isChecked: false));
    }

    _subTasks[task.id] = subtitles;
    notifyListeners();
  }
}