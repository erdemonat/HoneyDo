import 'package:flutter/material.dart';
import 'package:honeydo/components/task_card_components/task_title.dart';
import 'package:honeydo/components/task_card_components/subtitle_add_textfield.dart';
import 'package:honeydo/components/task_card_components/subtitle_list_tile.dart';
import 'package:honeydo/model/subtitle_model.dart';
import 'package:honeydo/components/task_card_components/progress_bar.dart';
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
      if (totalItems > 0) {
        completionPercentage = (completedSubtasks / totalItems) * 100;
      } else {
        // Reflect task completion status when no subtasks are present
        completionPercentage = widget.tasks.isChecked ? 100.0 : 0.0;
      }

      // Ensure the percentage doesn't exceed 100%
      if (completionPercentage > 100) {
        completionPercentage = 100.0;
      }

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

      // Update completion percentage when there are no subtasks
      if (_subtitles.isEmpty) {
        completionPercentage = isChecked ? 100.0 : 0.0;
      } else {
        completionPercentage = (completedSubtasks / _subtitles.length) * 100;
      }

      // Ensure the percentage doesn't exceed 100%
      if (completionPercentage > 100) {
        completionPercentage = 100.0;
      }
    });

    _loadSubTasks();
  }

  void _updateSubtitleCheckStatus(int index, bool? value) async {
    final subTask = widget.tasks.subtasks
        .where((st) => st.name == _subtitles[index].text)
        .first;

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

      completionPercentage = (_subtitles.isNotEmpty
              ? (completedSubtasks + (widget.tasks.isChecked ? 1 : 0)) /
                  (_subtitles.length)
              : 0.0) *
          100;

      // Ensure the percentage doesn't exceed 100%
      if (completionPercentage > 100) {
        completionPercentage = 100.0;
      }
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
                      onTaskChecked: (p0) {}, //_isTaskChecked
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
                                onDelete: (p0, p1) {}, //_deleteSubtitle
                                onUpdateCheckStatus:
                                    (p0, p1) {}, //_updateSubtitleCheckStatus
                              ),
                              SubTitleAddTextField(
                                controller: _subtitleController,
                                onSubmitted: (p0) {}, //_addSubtitle
                                hintext: 'Bir görev ekle',
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
