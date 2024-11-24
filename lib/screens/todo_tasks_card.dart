import 'dart:math';

import 'package:flutter/material.dart';
import 'package:honeydo/components/task_card_components/meal_card_tile.dart';
import 'package:honeydo/components/task_card_components/task_card_tile.dart';
import 'package:honeydo/components/task_card_components/task_text_field.dart';
import 'package:honeydo/data/random_task_sentence.dart';
import 'package:honeydo/providers/audio_player_provider.dart';
import 'package:honeydo/service/isar_service.dart';
import 'package:honeydo/providers/focus_date_provider.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksCard extends StatefulWidget {
  const TasksCard({super.key});

  @override
  State<TasksCard> createState() => _TasksCardState();
}

TextEditingController taskTextController = TextEditingController();

class _TasksCardState extends State<TasksCard> {
  late TasksMealsProvider tasksMealsProvider = Provider.of<TasksMealsProvider>(context, listen: true);
  late FocusDateProvider focusDateProvider = Provider.of<FocusDateProvider>(context, listen: false);
  late SoundEffectProvider soundEffectProvider = Provider.of<SoundEffectProvider>(context, listen: false);
  bool isDragging = false;
  bool taskMealToggle = false;
  bool isOnDeleteIcon = false;
  bool isOnShiftDateIcon = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await tasksMealsProvider.loadTasks(context);
        await tasksMealsProvider.loadMeals(context);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTaskPressed() async {
    String taskName = taskTextController.text;
    String taskDate = focusDateProvider.getFocusDate();
    if (taskTextController.text.isNotEmpty) {
      final random = Random();
      int randomNumber = 3 + random.nextInt(4);
      await IsarService().createOrUpdateTaskData(context, taskDate, taskName);
      soundEffectProvider.playSound('multiPop$randomNumber');
      await tasksMealsProvider.loadTasks(context);
    }
    taskTextController.clear();
  }

  void onMealPressed() async {
    String mealName = taskTextController.text;
    String mealDate = focusDateProvider.getFocusDate();
    if (taskTextController.text.isNotEmpty) {
      final random = Random();
      int randomNumber = 3 + random.nextInt(4);
      await IsarService().createOrUpdateMealData(mealDate, mealName);
      soundEffectProvider.playSound('multiPop$randomNumber');
      await tasksMealsProvider.loadMeals(context);
    }
    taskTextController.clear();
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
                  child: tasksMealsProvider.meals.isEmpty
                      ? Center(
                          child: Text(
                            AppLocalizations.of(context)!.mealCardHint,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.primary),
                          ),
                        )
                      : ListView.builder(
                          itemCount: tasksMealsProvider.meals.length,
                          itemBuilder: (context, index) {
                            return DragTarget<int>(
                              onAcceptWithDetails: (details) {
                                int oldIndex = details.data;
                                tasksMealsProvider.onReorderMeal(context, oldIndex, index);
                              },
                              builder: (context, candidateData, rejectedData) {
                                return Draggable<int>(
                                  data: index,
                                  dragAnchorStrategy: pointerDragAnchorStrategy,
                                  feedback: Material(
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          Card(
                                            color: Theme.of(context).colorScheme.secondary,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                tasksMealsProvider.meals[index].name,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
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
                                  child: MealCardTile(meals: tasksMealsProvider.meals[index]),
                                );
                              },
                            );
                          },
                        ),
                )
              : Expanded(
                  child: tasksMealsProvider.tasks.isEmpty
                      ? Center(
                          child: Text(
                            randomTaskSentences(context),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.primary),
                          ),
                        )
                      : ListView.builder(
                          itemCount: tasksMealsProvider.tasks.length,
                          itemBuilder: (context, index) {
                            return DragTarget<int>(
                              onAcceptWithDetails: (details) {
                                int oldIndex = details.data;
                                tasksMealsProvider.onReorderTask(context, oldIndex, index);
                              },
                              builder: (context, candidateData, rejectedData) {
                                return Draggable<int>(
                                  data: index,
                                  dragAnchorStrategy: pointerDragAnchorStrategy,
                                  feedback: Material(
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        Card(
                                          color: Theme.of(context).colorScheme.secondary,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              tasksMealsProvider.tasks[index].name,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                  child: TaskCardTile(
                                    tasks: tasksMealsProvider.tasks[index],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: isDragging,
                child: DragTarget<int>(
                  onAcceptWithDetails: (details) {
                    taskMealToggle ? tasksMealsProvider.removeMeal(context, details.data) : tasksMealsProvider.removeTask(context, details.data);
                    isOnDeleteIcon = false;
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            isOnDeleteIcon = true;
                          });
                        },
                        onExit: (_) {
                          isOnDeleteIcon = false;
                        },
                        child: Icon(
                          isOnDeleteIcon ? Icons.delete_sweep : Icons.delete,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 36.0,
                        ),
                      ),
                    );
                  },
                ),
              ),
              TaskTextField(
                onFieldSubmitted: (p0) => taskMealToggle ? onMealPressed() : onTaskPressed(),
                textcontroller: taskTextController,
                onPressed: taskMealToggle ? onMealPressed : onTaskPressed,
                onTaskMealToggle: () {
                  setState(() {
                    taskMealToggle = !taskMealToggle;
                  });
                },
                taskMealIcon: taskMealToggle ? Icons.restaurant : Icons.library_add_sharp,
                hintext: taskMealToggle ? AppLocalizations.of(context)!.hintTextMeal : AppLocalizations.of(context)!.hintTextTask,
              ),
              Visibility(
                visible: isDragging,
                child: DragTarget<int>(
                  onAcceptWithDetails: (details) {
                    tasksMealsProvider.shiftTaskDate(context, details.data);
                    isOnShiftDateIcon = false;
                  },
                  builder: (context, candidateData, rejectedData) {
                    return taskMealToggle
                        ? SizedBox(
                            height: 46,
                            width: 46,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: MouseRegion(
                              onEnter: (_) {
                                isOnShiftDateIcon = true;
                              },
                              onExit: (_) {
                                isOnShiftDateIcon = false;
                              },
                              child: Icon(
                                !isOnShiftDateIcon ? Symbols.move_selection_left : Symbols.move_selection_right,
                                color: Theme.of(context).colorScheme.tertiary,
                                size: 36.0,
                              ),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
