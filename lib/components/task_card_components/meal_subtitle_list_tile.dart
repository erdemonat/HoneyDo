import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/model/subtitle_model.dart';

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
        return InkWell(
          onLongPress: () {
            onDelete(index, subtitles[index].text);
          },
          child: ListTile(
            title: Text(
              subtitles[index].text,
              style: kCardSubTitleTextStyle(context),
            ),
          ),
        );
      },
    );
  }
}
