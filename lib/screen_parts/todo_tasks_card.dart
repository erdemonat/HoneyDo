import 'package:flutter/material.dart';
import 'package:honeydo/components/todo_task_screen_components/task_card_tile.dart';
import 'package:honeydo/components/todo_task_screen_components/task_text_field.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/focus_date_model.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:provider/provider.dart';

class TasksCard extends StatefulWidget {
  const TasksCard({super.key});

  @override
  State<TasksCard> createState() => _TasksCardState();
}

TextEditingController taskTextController = TextEditingController();

Future<HoneyDoData?> getTaskDataByName(String name) async {
  return await isar.honeyDoDatas.filter().nameEqualTo(name).findFirst();
}

Future<DateLinks?> getTaskDateByDate(
    HoneyDoData honeyDoData, String date) async {
  await honeyDoData.dateLinks.load();
  return honeyDoData.dateLinks.filter().dateEqualTo(date).findFirst();
}

Future<void> createOrUpdateTaskData(
    String taskDataName, String date, String taskName) async {
  await isar.writeTxn(() async {
    HoneyDoData? honeyDoData = await getTaskDataByName(taskDataName);
    if (honeyDoData == null) {
      honeyDoData = HoneyDoData()..name = taskDataName;
      await isar.honeyDoDatas.put(honeyDoData);
    }
    DateLinks? dateLink = await getTaskDateByDate(honeyDoData, date);
    if (dateLink == null) {
      dateLink = DateLinks()..date = date;
      await isar.dateLinks.put(dateLink);
      honeyDoData.dateLinks.add(dateLink);
      await honeyDoData.dateLinks.save();
    }
    await dateLink.tasks.load();
    int nextOrder = dateLink.tasks.length;

    final task = Task()
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
  await isar.writeTxn(() async {
    HoneyDoData? honeyDoData = await getTaskDataByName(mealDataName);
    if (honeyDoData == null) {
      honeyDoData = HoneyDoData()..name = mealDataName;
      await isar.honeyDoDatas.put(honeyDoData);
    }
    DateLinks? dateLink = await getTaskDateByDate(honeyDoData, date);
    if (dateLink == null) {
      dateLink = DateLinks()..date = date;
      await isar.dateLinks.put(dateLink);
      honeyDoData.dateLinks.add(dateLink);
      await honeyDoData.dateLinks.save();
    }
    await dateLink.meals.load();
    int nextOrder = dateLink.meals.length;

    final meal = Meal()
      ..name = mealName
      ..order = nextOrder;
    await isar.meals.put(meal);
    dateLink.meals.add(meal);
    await dateLink.meals.save();
  });
}

class _TasksCardState extends State<TasksCard> {
  List<Task> tasks = [];
  List<Meal> meals = [];
  bool isDragging = false;
  bool taskMealToggle = false;

  @override
  void initState() {
    super.initState();
    loadTasks();
    loadMeals();

    final focusDateModel = Provider.of<FocusDateModel>(context, listen: false);
    focusDateModel.addListener(() {
      loadTasks();
      loadMeals();
    });
  }

  @override
  void dispose() {
    final focusDateModel = Provider.of<FocusDateModel>(context, listen: false);
    focusDateModel.removeListener(loadTasks);
    super.dispose();
  }

  Future<void> loadTasks() async {
    final focusDateModel = Provider.of<FocusDateModel>(context, listen: false);
    String taskDate = DateFormat('ddMMyyyy').format(focusDateModel.focusDate);
    setState(() {
      tasks = [];
    });
    HoneyDoData? honeyDoData = await getTaskDataByName('HoneyDo Data');
    if (honeyDoData != null) {
      DateLinks? taskDateObj = await getTaskDateByDate(honeyDoData, taskDate);
      if (taskDateObj != null) {
        await taskDateObj.tasks.load();
        tasks = taskDateObj.tasks.toList()
          ..sort((a, b) => a.order.compareTo(b.order));
        setState(() {});
      }
    }
  }

  Future<void> loadMeals() async {
    final focusDateModel = Provider.of<FocusDateModel>(context, listen: false);
    String mealDate = DateFormat('ddMMyyyy').format(focusDateModel.focusDate);
    setState(() {
      meals = [];
    });
    HoneyDoData? honeyDoData = await getTaskDataByName('HoneyDo Data');
    if (honeyDoData != null) {
      DateLinks? mealDateObj = await getTaskDateByDate(honeyDoData, mealDate);
      if (mealDateObj != null) {
        await mealDateObj.meals.load();
        meals = mealDateObj.meals.toList()
          ..sort((a, b) => a.order.compareTo(b.order));
        setState(() {});
      }
    }
  }

  Future<void> _deleteTask(int index) async {
    final task = tasks[index];
    await isar.writeTxn(() async {
      await isar.tasks.delete(task.id);
    });
    setState(() {
      tasks.removeAt(index);
    });
  }

  Future<void> _deleteMeal(int index) async {
    final meal = meals[index];
    await isar.writeTxn(() async {
      await isar.meals.delete(meal.id);
    });
    setState(() {
      meals.removeAt(index);
    });
  }

  Future<void> _onReorderTask(int oldIndex, int newIndex) async {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Task item = tasks.removeAt(oldIndex);
      tasks.insert(newIndex, item);
    });

    await isar.writeTxn(() async {
      for (int i = 0; i < tasks.length; i++) {
        tasks[i].order = i;
        await isar.tasks.put(tasks[i]);
      }
    });
  }

  Future<void> _onReorderMeal(int oldIndex, int newIndex) async {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Meal item = meals.removeAt(oldIndex);
      meals.insert(newIndex, item);
    });

    await isar.writeTxn(() async {
      for (int i = 0; i < meals.length; i++) {
        meals[i].order = i;
        await isar.meals.put(meals[i]);
      }
    });
  }

  void onTaskPressed() async {
    final focusDateModel = Provider.of<FocusDateModel>(context, listen: false);
    String taskName = taskTextController.text;
    String taskDate = DateFormat('ddMMyyyy').format(focusDateModel.focusDate);
    if (taskName.isNotEmpty) {
      await createOrUpdateTaskData('HoneyDo Data', taskDate, taskName);
    }
    taskTextController.clear();
    loadTasks();
  }

  void onMealPressed() async {
    final focusDateModel = Provider.of<FocusDateModel>(context, listen: false);
    String mealName = taskTextController.text;
    String mealDate = DateFormat('ddMMyyyy').format(focusDateModel.focusDate);
    if (mealName.isNotEmpty) {
      await createOrUpdateMealData('HoneyDo Data', mealDate, mealName);
    }
    taskTextController.clear();
    loadMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          taskMealToggle
              ? Expanded(
                  child: meals.isEmpty
                      ? const Text('Sektir.')
                      : ListView.builder(
                          itemCount: meals.length,
                          itemBuilder: (context, index) {
                            return DragTarget<int>(
                              onAcceptWithDetails: (details) {
                                int oldIndex = details.data;
                                _onReorderMeal(oldIndex, index);
                              },
                              builder: (context, candidateData, rejectedData) {
                                return Draggable<int>(
                                  data: index,
                                  feedback: Material(
                                    color: Colors.transparent,
                                    child: SizedBox(
                                        height: 90,
                                        width: double.maxFinite,
                                        child: Text(meals[index].name)),
                                  ),
                                  childWhenDragging: Container(),
                                  onDragStarted: () {
                                    setState(() {
                                      isDragging = true;
                                    });
                                  },
                                  onDragCompleted: () {
                                    setState(() {
                                      isDragging = false;
                                    });
                                  },
                                  onDraggableCanceled: (_, __) {
                                    setState(() {
                                      isDragging = false;
                                    });
                                  },
                                  child: Container(
                                    child: Text(meals[index].name),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                )
              : Expanded(
                  child: tasks.isEmpty
                      ? const Text('Yapılacaklar Listesi Boş ....')
                      : ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            return DragTarget<int>(
                              onAcceptWithDetails: (details) {
                                int oldIndex = details.data;
                                _onReorderTask(oldIndex, index);
                              },
                              builder: (context, candidateData, rejectedData) {
                                return Draggable<int>(
                                  data: index,
                                  feedback: Material(
                                    color: Colors.transparent,
                                    child: SizedBox(
                                        height: 90,
                                        width: double.maxFinite,
                                        child:
                                            TaskCardTile(tasks: tasks[index])),
                                  ),
                                  childWhenDragging: Container(),
                                  onDragStarted: () {
                                    setState(() {
                                      isDragging = true;
                                    });
                                  },
                                  onDragCompleted: () {
                                    setState(() {
                                      isDragging = false;
                                    });
                                  },
                                  onDraggableCanceled: (_, __) {
                                    setState(() {
                                      isDragging = false;
                                    });
                                  },
                                  child: TaskCardTile(tasks: tasks[index]),
                                );
                              },
                            );
                          },
                        ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: TaskTextField(
                  textcontroller: taskTextController,
                  onPressed: taskMealToggle ? onMealPressed : onTaskPressed,
                  onTaskMealToggle: () {
                    setState(() {
                      taskMealToggle = !taskMealToggle;
                    });
                    print(taskMealToggle);
                  },
                  taskMealIcon: taskMealToggle
                      ? Icons.restaurant
                      : Icons.library_add_sharp,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Visibility(
                  visible: isDragging,
                  child: DragTarget<int>(
                    onAcceptWithDetails: (details) {
                      taskMealToggle
                          ? _deleteMeal(details.data)
                          : _deleteTask(details.data);
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 36.0,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
