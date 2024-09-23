import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:honeydo/providers/focus_date_provider.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.task.isChecked,
          onChanged: (value) {
            if (value != null) {
              widget.onTaskChecked(value);
            }
          },
          activeColor: Theme.of(context).colorScheme.surface,
          checkColor: Theme.of(context).colorScheme.tertiary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: widget.onPressed,
              child: GestureDetector(
                onSecondaryTapDown: (details) {
                  _showColorMenu(details.globalPosition);
                },
                child: Text(
                  textScaler: MediaQuery.textScalerOf(context),
                  widget.task.name,
                  style: widget.task.isMarked
                      ? TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 24,
                          decorationColor: Color(int.parse(widget.task.markColor)).withOpacity(0.25),
                        )
                      : kCardTitleTextStyle(context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showColorMenu(Offset position) async {
    final selectedColor = await showMenu<Color>(
      menuPadding: EdgeInsets.all(0),
      constraints: BoxConstraints(minHeight: 0, minWidth: 0),
      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.25),
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx, position.dy),
      items: [
        _buildColorBox(context, Colors.red),
        _buildColorBox(context, Colors.purple),
        _buildColorBox(context, Colors.green),
        _buildColorBox(context, Colors.yellow),
        _buildColorBox(context, Colors.orange),
        PopupMenuItem(
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Theme.of(context).colorScheme.tertiary),
              borderRadius: BorderRadius.circular(4),
            ),
            child: IconButton(
              onPressed: () async {
                await Provider.of<TasksMealsProvider>(context, listen: false).updateTaskMarkStatus(widget.task, "", false);
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.block,
                size: 10,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ),
      ],
    );

    if (selectedColor != null) {
      setState(() {
        widget.task.markColor = selectedColor.value.toString();
        widget.task.isMarked = true;
      });

      Provider.of<TasksMealsProvider>(context, listen: false).updateTaskMarkStatus(widget.task, selectedColor.value.toString(), true);
    }
  }

  PopupMenuEntry<Color> _buildColorBox(BuildContext context, Color color) {
    return PopupMenuItem<Color>(
      value: color,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        width: 30,
        height: 30,
      ),
    );
  }
}

class MoveToNextDayButton extends StatelessWidget {
  const MoveToNextDayButton({
    super.key,
    required this.context,
    required this.daysToDelay,
    required this.taskId,
  });

  final int daysToDelay;
  final BuildContext context;
  final int taskId;

  @override
  Widget build(BuildContext context) {
    var delayedDate = DateFormat('ddMMyyyy').format(Provider.of<FocusDateProvider>(context).focusDate.add(Duration(days: daysToDelay)));

    return GestureDetector(
      onTap: () {
        Provider.of<TasksMealsProvider>(context, listen: false).shiftTaskDate(taskId, daysToDelay);
      },
      child: Container(
        margin: const EdgeInsets.all(4.0),
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: Theme.of(context).colorScheme.tertiary),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
            child: Text(
          '+$daysToDelay',
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        )),
      ),
    );
  }
}
