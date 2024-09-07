import 'package:flutter/material.dart';
import 'package:honeydo/components/constants.dart';
import 'package:honeydo/components/todo_task_screen_components/subtitleitem_model.dart';

class SubtitleListTile extends StatelessWidget {
  final List<SubtitleItem> subtitles;
  final Function(int, String) onDelete;
  final Function(int, bool?) onUpdateCheckStatus;

  const SubtitleListTile({
    super.key,
    required this.subtitles,
    required this.onDelete,
    required this.onUpdateCheckStatus,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: subtitles.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onLongPress: () {
            onDelete(index, subtitles[index].text);
          },
          child: CheckboxListTile(
            activeColor: const Color(0xff0DC9AB),
            splashRadius: 0,
            checkColor: Theme.of(context).colorScheme.surface,
            side: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
              width: 1.5,
              strokeAlign: 1.5,
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: subtitles[index].isChecked,
            onChanged: (value) => onUpdateCheckStatus(index, value),
            title: Text(
              subtitles[index].text,
              style: cardSubTitleTextStyle(context),
            ),
          ),
        );
      },
    );
  }
}
