import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/model/subtitle_model.dart';

class TaskSubtitleListTile extends StatefulWidget {
  final List<SubtitleItem> subTaskTitles;
  final Function(int, String) onDelete;
  final Function(int, bool) onSubtaskChanged;

  const TaskSubtitleListTile({
    super.key,
    required this.subTaskTitles,
    required this.onDelete,
    required this.onSubtaskChanged,
  });

  @override
  State<TaskSubtitleListTile> createState() => _TaskSubtitleListTileState();
}

class _TaskSubtitleListTileState extends State<TaskSubtitleListTile> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.subTaskTitles.length,
      itemBuilder: (context, index) {
        return InkWell(
          onLongPress: () {
            widget.onDelete(index, widget.subTaskTitles[index].text);
          },
          child: ListTile(
            leading: Checkbox(
              activeColor: Theme.of(context).colorScheme.surface,
              checkColor: Theme.of(context).colorScheme.tertiary,
              value: widget.subTaskTitles[index].isChecked,
              onChanged: (bool? value) {
                setState(() {
                  widget.subTaskTitles[index].isChecked = value!;
                });
                widget.onSubtaskChanged(index, value!);
              },
            ),
            title: Text(
              widget.subTaskTitles[index].text,
              style: kCardSubTitleTextStyle(context),
            ),
          ),
        );
      },
    );
  }
}
