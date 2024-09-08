import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/components/task_card_components/meal_subtitle_add_textfield.dart';
import 'package:honeydo/components/task_card_components/meal_subtitle_list_tile.dart';
import 'package:honeydo/model/subtitle_model.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/task_model.dart';

class MealCardTile extends StatefulWidget {
  final Meal meals;
  const MealCardTile({
    super.key,
    required this.meals,
  });

  @override
  MealCardTileState createState() => MealCardTileState();
}

class MealCardTileState extends State<MealCardTile> {
  final List<SubtitleItem> _subtitles = [];
  final TextEditingController _subtitleController = TextEditingController();

  static const double _collapsedHeight = 100.0;
  static const double _expandedBaseHeight = 200.0;
  static const double _subtitleHeightIncrement = 30.0;

  double _cardHeight = _collapsedHeight;
  double _currentExpandedHeight = _expandedBaseHeight;
  double completionPercentage = 0.0;
  int completedSubtasks = 0;

  void _toggleCardHeight() {
    setState(() {
      if (_cardHeight == _collapsedHeight) {
        _cardHeight = _currentExpandedHeight;
      } else {
        _cardHeight = _collapsedHeight;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSubMeals();
  }

  @override
  void dispose() {
    _subtitleController.dispose();
    super.dispose();
  }

  Future<void> _loadSubMeals() async {
    await widget.meals.submeals.load();
    if (!mounted) return;

    setState(() {
      _subtitles.clear();
      for (final subMeal in widget.meals.submeals) {
        _subtitles.add(
          SubtitleItem(text: subMeal.name),
        );
      }

      _currentExpandedHeight =
          _expandedBaseHeight + _subtitles.length * _subtitleHeightIncrement;

      if (_cardHeight > _collapsedHeight) {
        _cardHeight = _currentExpandedHeight;
      }
    });
  }

  // Future<void> _addSubtitle(String subtitleText) async {

  //   final subMeal = SubMeal()..name = subtitleText;

  //   await isar.writeTxn(() async {
  //     subMeal.meal.value = widget.meals;
  //     await isar.subMeals.put(subMeal);
  //     widget.meals.submeals.add(subMeal);
  //     await widget.meals.submeals.save();
  //   });

  //   if (!mounted) return;

  //   await _loadSubMeals();
  //   _subtitleController.clear();
  // }

  // Future<void> _deleteSubtitle(int index, String subtitleText) async {
  //   final subMeal =
  //       widget.meals.submeals.where((st) => st.name == subtitleText).first;

  //   await isar.writeTxn(() async {
  //     widget.meals.submeals.remove(subMeal);
  //     await widget.meals.submeals.save();
  //     await isar.subMeals.delete(subMeal.id);
  //   });

  //   if (!mounted) return;

  //   await _loadSubMeals();
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _cardHeight,
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: _toggleCardHeight,
                              child: Text(
                                widget.meals.name,
                                style: cardTitleTextStyle(context),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_cardHeight > _collapsedHeight) ...[
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              MealSubtitleListTile(
                                subtitles: _subtitles,
                                onDelete: (p0, p1) {}, //_deleteSubtitle
                              ),
                              MealSubTitleAddTextField(
                                controller: _subtitleController,
                                onSubmitted: (p0) {}, //_addSubtitle
                                hintext: 'Yediklerini yaz',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
