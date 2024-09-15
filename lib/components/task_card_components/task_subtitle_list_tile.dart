import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/model/subtitle_model.dart';

class TaskSubtitleListTile extends StatelessWidget {
  final List<SubtitleItem> subTaskTitles;
  final Function(int, String) onDelete;
  final void Function(bool?) onChanged;
  final bool checkboxValue;

  const TaskSubtitleListTile({
    super.key,
    required this.subTaskTitles,
    required this.onDelete,
    required this.onChanged,
    required this.checkboxValue,
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
              value: checkboxValue,
              onChanged: onChanged,
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
