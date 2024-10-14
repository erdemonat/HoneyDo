import 'package:flutter/material.dart';
import 'package:honeydo/components/task_card_components/meal_card_tile.dart';
import 'package:honeydo/components/task_card_components/task_card_tile.dart';
import 'package:honeydo/components/task_card_components/task_text_field.dart';
import 'package:honeydo/data/random_task_sentence.dart';
import 'package:honeydo/providers/audio_player_provider.dart';
import 'package:honeydo/service/isar_service.dart';
import 'package:honeydo/providers/focus_date_provider.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
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
      await IsarService().createOrUpdateTaskData(context, taskDate, taskName);
      soundEffectProvider.playSound('notificationBeep');
      await tasksMealsProvider.loadTasks(context);
    }
    taskTextController.clear();
  }

  void onMealPressed() async {
    String mealName = taskTextController.text;
    String mealDate = focusDateProvider.getFocusDate();
    if (taskTextController.text.isNotEmpty) {
      await IsarService().createOrUpdateMealData(mealDate, mealName);
      soundEffectProvider.playSound('notificationBeep');
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
                                  feedback: Material(
                                    color: Colors.transparent,
                                    child: SizedBox(height: 90, width: double.maxFinite, child: MealCardTile(meals: tasksMealsProvider.meals[index])),
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
                                  feedback: Material(
                                    color: Colors.transparent,
                                    child: SizedBox(
                                        height: 90,
                                        width: double.maxFinite,
                                        child: TaskCardTile(
                                          tasks: tasksMealsProvider.tasks[index],
                                        )),
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
                  },
                  taskMealIcon: taskMealToggle ? Icons.restaurant : Icons.library_add_sharp,
                  hintext: taskMealToggle ? AppLocalizations.of(context)!.hintTextMeal : AppLocalizations.of(context)!.hintTextTask,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Visibility(
                  visible: isDragging,
                  child: DragTarget<int>(
                    onAcceptWithDetails: (details) {
                      taskMealToggle ? tasksMealsProvider.removeMeal(context, details.data) : tasksMealsProvider.removeTask(context, details.data);
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
