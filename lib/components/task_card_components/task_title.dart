import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/isar_service.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:honeydo/providers/focus_date_provider.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
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
          onChanged: (value) {}, //_updateTaskCheckedStatus
          activeColor: const Color(0xff0DC9AB),
          checkColor: Theme.of(context).colorScheme.surface,
          side: BorderSide(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
            width: 1.5,
          ),
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
                          decorationColor:
                              Color(int.parse(widget.task.markColor))
                                  .withOpacity(0.25),
                        )
                      : cardTitleTextStyle(context),
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
      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.25),
      context: context,
      position: RelativeRect.fromLTRB(
          position.dx, position.dy, position.dx, position.dy),
      items: [
        PopupMenuItem(
          child: Column(
            children: [
              Row(
                children: [
                  _buildColorBox(context, Colors.red),
                  _buildColorBox(context, Colors.purple),
                  _buildColorBox(context, Colors.green),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildColorBox(context, Colors.yellow),
                  _buildColorBox(context, Colors.orange),
                  Container(
                    margin: const EdgeInsets.all(4.0),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2.0,
                          color: Theme.of(context).colorScheme.tertiary),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: IconButton(
                        onPressed: () async {
                          // setState(() {
                          //   widget.task.isMarked = false;
                          // });

                          // await isar.writeTxn(
                          //   () async {
                          //     await isar.tasks.put(widget.task);
                          //   },
                          // );
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.block,
                          size: 10,
                          color: Theme.of(context).colorScheme.tertiary,
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  MoveToNextDayButton(
                    taskId: widget.task.id,
                    context: context,
                    daysToDelay: 1,
                  ),
                  MoveToNextDayButton(
                    taskId: widget.task.id,
                    context: context,
                    daysToDelay: 2,
                  ),
                  MoveToNextDayButton(
                    taskId: widget.task.id,
                    context: context,
                    daysToDelay: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    // if (selectedColor != null) {
    //   setState(() {
    //     widget.task.markColor = selectedColor.value.toString();
    //     widget.task.isMarked = true;
    //   });

    //   await isar.writeTxn(
    //     () async {
    //       await isar.tasks.put(widget.task);
    //     },
    //   );
    // }
  }

  Widget _buildColorBox(BuildContext context, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(color);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        width: 30,
        height: 30,
        margin: const EdgeInsets.all(4.0),
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
    var delayedDate = DateFormat('ddMMyyyy').format(
        Provider.of<FocusDateProvider>(context)
            .focusDate
            .add(Duration(days: daysToDelay)));

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(4.0),
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2.0, color: Theme.of(context).colorScheme.tertiary),
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
