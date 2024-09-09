import 'package:flutter/material.dart';
import 'package:honeydo/components/task_card_components/meal_card_tile.dart';
import 'package:honeydo/components/task_card_components/task_card_tile.dart';
import 'package:honeydo/components/task_card_components/task_text_field.dart';
import 'package:honeydo/isar_service.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/providers/focus_date_provider.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:provider/provider.dart';

class TasksCard extends StatefulWidget {
  const TasksCard({super.key});

  @override
  State<TasksCard> createState() => _TasksCardState();
}

TextEditingController taskTextController = TextEditingController();

class _TasksCardState extends State<TasksCard> {
  List<Task> tasks = [];
  List<Meal> meals = [];
  bool isDragging = false;
  bool taskMealToggle = false;

  @override
  void initState() {
    loadTasks();
    loadMeals();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _deleteTask(int index) async {
    isarService.deleteTask(index, tasks);
    setState(() {
      tasks.removeAt(index);
    });
  }

  Future<void> _deleteMeal(int index) async {
    isarService.deleteMeal(index, meals);
    setState(() {
      meals.removeAt(index);
    });
  }

  Future<void> loadTasks() async {
    String taskDate =
        Provider.of<FocusDateProvider>(context, listen: false).getFocusDate();
    setState(() {
      tasks = [];
    });
    HoneyDoData? honeyDoData = await isarService.getTaskDataByName();
    if (honeyDoData != null) {
      DateLinks? taskDateObj =
          await isarService.getTaskDateByDate(honeyDoData, taskDate);
      if (taskDateObj != null) {
        await taskDateObj.tasks.load();
        tasks = taskDateObj.tasks.toList()
          ..sort((a, b) => a.order.compareTo(b.order));
        setState(() {});
      }
    }
  }

  Future<void> loadMeals() async {
    String mealDate =
        Provider.of<FocusDateProvider>(context, listen: false).getFocusDate();
    setState(() {
      meals = [];
    });
    HoneyDoData? honeyDoData = await isarService.getTaskDataByName();
    if (honeyDoData != null) {
      DateLinks? mealDateObj =
          await isarService.getTaskDateByDate(honeyDoData, mealDate);
      if (mealDateObj != null) {
        await mealDateObj.meals.load();
        meals = mealDateObj.meals.toList()
          ..sort((a, b) => a.order.compareTo(b.order));
        setState(() {});
      }
    }
  }

  void onTaskPressed() async {
    String taskName = taskTextController.text;
    String taskDate =
        Provider.of<FocusDateProvider>(context, listen: false).getFocusDate();
    IsarService().createOrUpdateTaskData(taskDate, taskName);
    loadTasks();
  }

  void onMealPressed() async {
    String mealName = taskTextController.text;
    String mealDate =
        Provider.of<FocusDateProvider>(context, listen: false).getFocusDate();
    IsarService().createOrUpdateMealData(mealDate, mealName);
    loadMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          taskMealToggle
              ? Expanded(
                  child: meals.isEmpty
                      ? const Text('Yediklerin yazılmamış..')
                      : ListView.builder(
                          itemCount: meals.length,
                          itemBuilder: (context, index) {
                            return DragTarget<int>(
                              onAcceptWithDetails: (details) {
                                int oldIndex = details.data;
                                // _onReorderMeal(oldIndex, index);
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
                                            MealCardTile(meals: meals[index])),
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
                                  child: MealCardTile(meals: meals[index]),
                                );
                              },
                            );
                          },
                        ),
                )
              : Expanded(
                  child: tasks.isEmpty
                      ? const Text('Yapılacaklar yazılmamış ....')
                      : ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            return DragTarget<int>(
                              onAcceptWithDetails: (details) {
                                int oldIndex = details.data;
                                // _onReorderTask(oldIndex, index);
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 46,
                height: 46,
              ),
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
                  hintext: taskMealToggle
                      ? "Bugün ne yedin?"
                      : "Her şey bir adımla başlar!",
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
