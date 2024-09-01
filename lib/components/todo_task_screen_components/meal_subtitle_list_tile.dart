import 'package:flutter/material.dart';
import 'package:honeydo/components/constants.dart';
import 'package:honeydo/components/todo_task_screen_components/subtitleitem_model.dart';

class MealSubtitleListTile extends StatelessWidget {
  final List<SubtitleItem> subtitles;
  final Function(int, String) onDelete;

  const MealSubtitleListTile({
    super.key,
    required this.subtitles,
    required this.onDelete,
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
          child: ListTile(
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
