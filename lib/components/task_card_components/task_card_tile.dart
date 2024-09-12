import 'package:flutter/material.dart';
import 'package:honeydo/components/task_card_components/task_title.dart';
import 'package:honeydo/components/task_card_components/subtitle_add_textfield.dart';
import 'package:honeydo/components/task_card_components/subtitle_list_tile.dart';
import 'package:honeydo/model/subtitle_model.dart';
import 'package:honeydo/components/task_card_components/progress_bar.dart';
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
  }

  @override
  void dispose() {
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksMealsProvider = Provider.of<TasksMealsProvider>(context, listen: false);
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
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 14),
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
                            strokeCap: StrokeCap.round,
                            value: completionPercentage / 100,
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
                    if (_cardHeight > _collapsedHeight) const SizedBox(height: 20),
                    if (_cardHeight > _collapsedHeight)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SubtitleListTile(
                                subtitles: _subtitles,
                                onDelete: (p0, p1) {}, //_deleteSubtitle
                                onUpdateCheckStatus: (p0, p1) {
                                  tasksMealsProvider.updateSubtitleCheckStatus;
                                },
                              ),
                              SubTitleAddTextField(
                                controller: _subtitleController,
                                onSubmitted: (p0) {
                                  tasksMealsProvider.addSubtitle(widget.tasks, _subtitleController.text);
                                  _subtitleController.clear();
                                },
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
