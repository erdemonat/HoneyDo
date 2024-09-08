import 'package:flutter/material.dart';
import 'package:honeydo/components/task_card_components/meal_card_tile.dart';
import 'package:honeydo/components/task_card_components/task_card_tile.dart';
import 'package:honeydo/components/task_card_components/task_text_field.dart';
import 'package:honeydo/providers/focus_date_provider.dart';
import 'package:intl/intl.dart';
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
  static List<Meal> meals = [];
  bool isDragging = false;
  bool taskMealToggle = false;

  @override
  void initState() {
    super.initState();

    final focusDateModel =
        Provider.of<FocusDateProvider>(context, listen: false);
    focusDateModel.addListener(() {});
  }

  @override
  void dispose() {
    final focusDateModel =
        Provider.of<FocusDateProvider>(context, listen: false);
    super.dispose();
  }

  void onTaskPressed() async {
    final focusDateModel =
        Provider.of<FocusDateProvider>(context, listen: false);
    String taskName = taskTextController.text;
    String taskDate = DateFormat('ddMMyyyy').format(focusDateModel.focusDate);
  }

  void onMealPressed() async {
    final focusDateModel =
        Provider.of<FocusDateProvider>(context, listen: false);
    String mealName = taskTextController.text;
    String mealDate = DateFormat('ddMMyyyy').format(focusDateModel.focusDate);
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
              if (!taskMealToggle)
                SizedBox(
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
                      // taskMealToggle
                      //     ? _deleteMeal(details.data)
                      //     : _deleteTask(details.data);
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
