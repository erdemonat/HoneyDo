import 'package:flutter/material.dart';
import 'package:honeydo/components/task_text_field.dart';

class TasksCard extends StatefulWidget {
  const TasksCard({super.key});

  @override
  State<TasksCard> createState() => _TasksCardState();
}

class _TasksCardState extends State<TasksCard> {
  @override
  Widget build(BuildContext context) {
    TextEditingController taskTextController = TextEditingController();
    String taskName = "ses";
    int taskListId = 08092024;
    List<String> taskList = [];
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('data'),
          TaskTextField(
            textcontroller: taskTextController,
            onPressed: () {
              setState(() {
                taskName = taskTextController.text;
                taskList.add(taskName);
                print(taskList);
              });
            },
          ),
        ],
      ),
    );
  }
}
