import 'package:flutter/material.dart';
import 'package:honeydo/components/todo_task_screen_components/task_title.dart';
import 'package:honeydo/components/todo_task_screen_components/subtitle_add_textfield.dart';
import 'package:honeydo/components/todo_task_screen_components/subtitle_list_tile.dart';
import 'package:honeydo/components/todo_task_screen_components/subtitleitem_model.dart';
import 'package:honeydo/components/todo_task_screen_components/progress_bar.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/task_model.dart';

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
  final List<SubtitleItem> _subtitles = [];
  final TextEditingController _subtitleController = TextEditingController();

  static const double _collapsedHeight = 100.0;
  static const double _expandedBaseHeight = 200.0;
  static const double _subtitleHeightIncrement = 30.0;

  double _cardHeight = _collapsedHeight;
  double _currentExpandedHeight = _expandedBaseHeight;
  double completionPercentage = 0.0;
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
    _loadSubTasks();
  }

  @override
  void dispose() {
    _subtitleController.dispose();
    super.dispose();
  }

  Future<void> _loadSubTasks() async {
    await widget.tasks.subtasks.load();
    if (!mounted) return;

    completedSubtasks = 0;

    setState(() {
      _subtitles.clear();
      for (final subTask in widget.tasks.subtasks) {
        _subtitles.add(
          SubtitleItem(text: subTask.name, isChecked: subTask.isChecked),
        );
        if (subTask.isChecked) {
          completedSubtasks++;
        }
      }

      final totalItems = _subtitles.length;
      completionPercentage = (completedSubtasks / totalItems) * 100;

      _currentExpandedHeight =
          _expandedBaseHeight + _subtitles.length * _subtitleHeightIncrement;

      if (_cardHeight > _collapsedHeight) {
        _cardHeight = _currentExpandedHeight;
      }
    });
  }

  void _isTaskChecked(bool isChecked) async {
    setState(() {
      if (isChecked) {
        completedSubtasks = _subtitles.length;
        for (var subtitle in _subtitles) {
          subtitle.isChecked = true;
        }
      } else {
        completedSubtasks = 0;
        for (var subtitle in _subtitles) {
          subtitle.isChecked = false;
        }
      }
    });

    await isar.writeTxn(() async {
      for (final subTask in widget.tasks.subtasks) {
        subTask.isChecked = isChecked;
        await isar.subTasks.put(subTask);
      }

      widget.tasks.isChecked = isChecked;
      await isar.tasks.put(widget.tasks);
    });

    _loadSubTasks();
  }

  Future<void> _addSubtitle(String subtitleText) async {
    final subTask = SubTask()
      ..name = subtitleText
      ..isChecked = false;

    await isar.writeTxn(() async {
      subTask.task.value = widget.tasks;
      await isar.subTasks.put(subTask);
      widget.tasks.subtasks.add(subTask);
      await widget.tasks.subtasks.save();
    });

    if (!mounted) return;

    await _loadSubTasks();
    _subtitleController.clear();
  }

  Future<void> _deleteSubtitle(int index, String subtitleText) async {
    final subTask =
        widget.tasks.subtasks.where((st) => st.name == subtitleText).first;

    await isar.writeTxn(() async {
      widget.tasks.subtasks.remove(subTask);
      await widget.tasks.subtasks.save();
      await isar.subTasks.delete(subTask.id);
    });

    if (!mounted) return;

    await _loadSubTasks();
  }

  void _updateSubtitleCheckStatus(int index, bool? value) async {
    final subTask = widget.tasks.subtasks
        .where((st) => st.name == _subtitles[index].text)
        .first;

    await isar.writeTxn(() async {
      subTask.isChecked = value ?? false;
      await isar.subTasks.put(subTask);
    });

    if (!mounted) return;

    setState(() {
      _subtitles[index].isChecked = value ?? false;

      completedSubtasks =
          _subtitles.where((subtask) => subtask.isChecked).length;

      if (completedSubtasks == _subtitles.length && _subtitles.isNotEmpty) {
        widget.tasks.isChecked = true;
      } else {
        widget.tasks.isChecked = false;
      }

      isar.writeTxn(() async {
        await isar.tasks.put(widget.tasks);
      });

      completionPercentage = (_subtitles.isNotEmpty
              ? (completedSubtasks + (widget.tasks.isChecked ? 1 : 0)) /
                  (_subtitles.length)
              : 0.0) *
          100;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          '${completionPercentage.toStringAsFixed(0)}%',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .tertiary
                                .withOpacity(0.3),
                            strokeCap: StrokeCap.round,
                            value: completionPercentage / 100,
                            color: const Color(0xff0DC9AB),
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
                    subTaskLength: _subtitles.length,
                    completedTasks: completedSubtasks,
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
                      onTaskChecked: _isTaskChecked,
                    ),
                    if (_cardHeight > _collapsedHeight)
                      const SizedBox(height: 20),
                    if (_cardHeight > _collapsedHeight)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SubtitleListTile(
                                subtitles: _subtitles,
                                onDelete: _deleteSubtitle,
                                onUpdateCheckStatus: _updateSubtitleCheckStatus,
                              ),
                              SubTitleAddTextField(
                                controller: _subtitleController,
                                onSubmitted: _addSubtitle,
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