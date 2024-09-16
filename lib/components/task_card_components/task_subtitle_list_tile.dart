import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/model/subtitle_model.dart';

class TaskSubtitleListTile extends StatelessWidget {
  final List<SubtitleItem> subTaskTitles;
  final Function(int, String) onDelete;
  final Function(int, bool) onSubtaskChanged; // Updated to handle changes for individual subtasks

  const TaskSubtitleListTile({
    super.key,
    required this.subTaskTitles,
    required this.onDelete,
    required this.onSubtaskChanged, // Updated signature
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: subTaskTitles.length,
      itemBuilder: (context, index) {
        return InkWell(
          onLongPress: () {
            onDelete(index, subTaskTitles[index].text);
          },
          child: ListTile(
            leading: Checkbox(
              value: subTaskTitles[index].isChecked, // Reflects the individual isChecked state
              onChanged: (bool? value) {
                if (value != null) {
                  onSubtaskChanged(index, value); // Pass the index and new value
                }
              },
            ),
            title: Text(
              subTaskTitles[index].text,
              style: kCardSubTitleTextStyle(context),
            ),
          ),
        );
      },
    );
  }
}
