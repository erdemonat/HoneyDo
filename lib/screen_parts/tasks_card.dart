import 'package:flutter/material.dart';
import 'package:honeydo/components/task_card.dart';
import 'package:honeydo/components/task_text_field.dart';
import 'package:honeydo/main.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:honeydo/model/task_model.dart';

class TasksCard extends StatefulWidget {
  const TasksCard({super.key});

  @override
  State<TasksCard> createState() => _TasksCardState();
}

TextEditingController taskTextController = TextEditingController();

Future<TaskData?> getTaskDataByName(String name) async {
  return await isar.taskDatas.filter().nameEqualTo(name).findFirst();
}

Future<TaskDate?> getTaskDateByDate(TaskData taskData, String date) async {
  await taskData.taskDates.load();
  return taskData.taskDates.filter().dateEqualTo(date).findFirst();
}

Future<void> createOrUpdateTaskData(
    String taskDataName, String date, String taskName) async {
  await isar.writeTxn(() async {
    TaskData? taskData = await getTaskDataByName(taskDataName);
    if (taskData == null) {
      taskData = TaskData()..name = taskDataName;
      await isar.taskDatas.put(taskData);
    }
    TaskDate? taskDate = await getTaskDateByDate(taskData, date);
    if (taskDate == null) {
      taskDate = TaskDate()..date = date;
      await isar.taskDates.put(taskDate);
      taskData.taskDates.add(taskDate);
      await taskData.taskDates.save();
    }
    await taskDate.tasks.load();
    int nextOrder = taskDate.tasks.length;

    final task = Task()
      ..name = taskName
      ..order = nextOrder;
    await isar.tasks.put(task);
    taskDate.tasks.add(task);
    await taskDate.tasks.save();
  });
}

class _TasksCardState extends State<TasksCard> {
  List<Task> tasks = [];
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    String taskDate = DateFormat('ddMMyyyy').format(DateTime.now());
    TaskData? taskData = await getTaskDataByName('Tasks Data');
    if (taskData != null) {
      TaskDate? taskDateObj = await getTaskDateByDate(taskData, taskDate);
      if (taskDateObj != null) {
        await taskDateObj.tasks.load();
        tasks = taskDateObj.tasks.toList()
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

  Future<void> _onReorder(int oldIndex, int newIndex) async {
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

  void onPressed() async {
    String taskName = taskTextController.text;
    String taskDate = DateFormat('ddMMyyyy').format(DateTime.now());
    await createOrUpdateTaskData('Tasks Data', taskDate, taskName);
    taskTextController.clear();
    _loadTasks();
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
          Expanded(
            child: tasks.isEmpty
                ? const Text('Yapılacaklar Listesi Boş ....')
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return DragTarget<int>(
                        onAcceptWithDetails: (details) {
                          int oldIndex = details.data;
                          _onReorder(oldIndex, index);
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Draggable<int>(
                            data: index,
                            feedback: Material(
                              color: Colors.transparent,
                              child: SizedBox(
                                  height: 90,
                                  width: double.maxFinite,
                                  child: MyTaskCard(tasks: tasks[index].name)),
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
                            child: MyTaskCard(tasks: tasks[index].name),
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
                  onPressed: onPressed,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Visibility(
                  visible: isDragging,
                  child: DragTarget<int>(
                    onAcceptWithDetails: (details) {
                      _deleteTask(details.data);
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
