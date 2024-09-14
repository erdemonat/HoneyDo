import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/model/subtitle_model.dart';

class MealSubtitleListTile extends StatelessWidget {
  final List<SubtitleItem> subMealTitles;
  final Function(int, String) onDelete;

  const MealSubtitleListTile({
    super.key,
    required this.subMealTitles,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: subMealTitles.length,
      itemBuilder: (context, index) {
        return InkWell(
          onLongPress: () {
            onDelete(index, subMealTitles[index].text);
          },
          child: ListTile(
            leading: Text(
              '•',
              style: TextStyle(fontSize: 24),
            ),
            title: Text(
              subMealTitles[index].text,
              style: kCardSubTitleTextStyle(context),
            ),
          ),
        );
      },
    );
  }
}
