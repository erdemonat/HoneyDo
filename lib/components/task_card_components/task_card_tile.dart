import 'package:flutter/material.dart';
import 'package:honeydo/components/task_card_components/sub_item_text_field.dart';
import 'package:honeydo/components/task_card_components/task_subtitle_list_tile.dart';
import 'package:honeydo/components/task_card_components/task_title.dart';
import 'package:honeydo/components/task_card_components/progress_bar.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
import 'package:provider/provider.dart';

class TaskCardTile extends StatefulWidget {
  final Task tasks;

  const TaskCardTile({
    super.key,
    required this.tasks,
  });

  @override
  TaskCardTileState createState() => TaskCardTileState();
}

class TaskCardTileState extends State<TaskCardTile> {
  final TextEditingController _subtitleController = TextEditingController();

  static const double _collapsedHeight = 100.0;
  static const double _expandedBaseHeight = 200.0;
  static const double _subtitleHeightIncrement = 30.0;

  double _cardHeight = _collapsedHeight;
  double _currentExpandedHeight = _expandedBaseHeight;
  int completedSubtasks = 0;

  void _toggleCardHeight() {
    setState(() {
      if (_cardHeight == _collapsedHeight) {
        _cardHeight = _currentExpandedHeight;
      } else {
        _cardHeight = _collapsedHeight;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final tasksMealsProvider = Provider.of<TasksMealsProvider>(context, listen: false);
      tasksMealsProvider.loadSubTasks(widget.tasks);
    });
  }

  @override
  void dispose() {
    _subtitleController.dispose();
    super.dispose();
  }

  Future<void> _deleteSubTask(int taskId, String subtitleText) async {
    final tasksMealsProvider = Provider.of<TasksMealsProvider>(context, listen: false);
    await tasksMealsProvider.deleteSubTask(taskId, subtitleText);
    await tasksMealsProvider.loadSubTasks(widget.tasks);
  }

  @override
  Widget build(BuildContext context) {
    final tasksMealsProvider = Provider.of<TasksMealsProvider>(context, listen: false);
    final subTasks = tasksMealsProvider.getSubTask(widget.tasks.id);
    final completedPercantage = tasksMealsProvider.completedSubtasksPercentage(widget.tasks.id);

    void toggleTaskChecked() {
      final newStatus = !widget.tasks.isChecked;
      setState(() {
        widget.tasks.isChecked = newStatus;
      });
    }

    _currentExpandedHeight = _expandedBaseHeight + subTasks.length * _subtitleHeightIncrement;
    if (_cardHeight > _collapsedHeight) {
      _cardHeight = _currentExpandedHeight;
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _cardHeight,
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              if (_cardHeight == _collapsedHeight)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: 50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          widget.tasks.isChecked ? '%100' : '%${completedPercantage.toStringAsFixed(0)}',
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 14),
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
                            strokeCap: StrokeCap.round,
                            value: (widget.tasks.isChecked ? 100 : completedPercantage) / 100,
                            color: Theme.of(context).colorScheme.tertiary,
                            strokeAlign: 3,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              if (_cardHeight > _collapsedHeight)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ProgressBar(
                    subTaskLength: subTasks.length,
                    completedTasks: tasksMealsProvider.completedSubTaskCount(widget.tasks.id),
                    isTaskChecked: widget.tasks.isChecked,
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TaskTitle(
                      task: widget.tasks,
                      onPressed: _toggleCardHeight,
                      onTaskChecked: (bool isChecked) {
                        toggleTaskChecked();
                        isarService.updateTask(widget.tasks);
                      },
                    ),
                    if (_cardHeight > _collapsedHeight) const SizedBox(height: 20),
                    if (_cardHeight > _collapsedHeight)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TaskSubtitleListTile(
                                subTaskTitles: subTasks,
                                onDelete: (p0, p1) {
                                  _deleteSubTask(widget.tasks.id, p1);
                                },
                                onSubtaskChanged: (index, isChecked) {
                                  int subTaskId = subTasks[index].id;
                                  tasksMealsProvider.updateSubtaskCheckedStatus(widget.tasks.id, subTaskId, isChecked);
                                  print(subTasks[index].isChecked);
                                },
                              ),
                              SubItemTextField(
                                controller: _subtitleController,
                                onSubmitted: (p0) {
                                  tasksMealsProvider.addSubTask(widget.tasks, _subtitleController.text);
                                  tasksMealsProvider.loadSubTasks(widget.tasks);
                                  _subtitleController.clear();
                                },
                                hintext: 'Yaptıklarını yazacaksın',
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
