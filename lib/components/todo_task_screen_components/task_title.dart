import 'package:flutter/material.dart';
import 'package:honeydo/components/constants.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:honeydo/main.dart';

class TaskTitle extends StatefulWidget {
  final Task task;
  final VoidCallback onPressed;
  final Function(bool) onTaskChecked;

  const TaskTitle({
    super.key,
    required this.task,
    required this.onPressed,
    required this.onTaskChecked,
  });

  @override
  TaskTitleState createState() => TaskTitleState();
}

class TaskTitleState extends State<TaskTitle> {
  void _updateTaskCheckedStatus(bool? value) async {
    final isChecked = value ?? false;

    setState(() {
      widget.task.isChecked = isChecked;
    });

    await isar.writeTxn(() async {
      if (isChecked) {
        await widget.task.subtasks.load();
        for (final subtask in widget.task.subtasks) {
          subtask.isChecked = true;
          await isar.subTasks.put(subtask);
        }
      }
      await isar.tasks.put(widget.task);
    });

    widget.onTaskChecked(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: const Color(0xff0DC9AB),
      checkColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide(
        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
        width: 1.5,
        strokeAlign: 1.5,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      value: widget.task.isChecked,
      onChanged: _updateTaskCheckedStatus,
      title: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: widget.onPressed,
          child: Text(
            widget.task.name,
            style: cardTitleTextstyle,
          ),
        ),
      ),
    );
  }
}
