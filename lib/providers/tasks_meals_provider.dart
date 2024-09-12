import 'package:flutter/material.dart';
import 'package:honeydo/isar_service.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:honeydo/providers/focus_date_provider.dart';
import 'package:provider/provider.dart';

class TasksMealsProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Meal> _meals = [];

  List<Task> get tasks => _tasks;
  List<Meal> get meals => _meals;

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
    notifyListeners(); // UI'yi güncelle
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

    notifyListeners(); // UI'yi güncelle
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

    await IsarService().onReorderMeal(context, oldIndex, newIndex);

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
}
