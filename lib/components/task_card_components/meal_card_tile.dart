import 'package:flutter/material.dart';
import 'package:honeydo/components/task_card_components/sub_item_text_field.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/components/task_card_components/meal_subtitle_list_tile.dart';
import 'package:honeydo/model/subtitle_model.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
import 'package:provider/provider.dart';

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

      _currentExpandedHeight = _expandedBaseHeight + _subtitles.length * _subtitleHeightIncrement;

      if (_cardHeight > _collapsedHeight) {
        _cardHeight = _currentExpandedHeight;
      }
    });
  }

  Future<void> _deleteSubMeal(int mealId, String subtitleText) async {
    try {
      // Silme işlemi öncesinde herhangi bir transaction olmadığından emin olalım
      await Provider.of<TasksMealsProvider>(context, listen: false).deleteSubMeal(mealId, subtitleText);
    } catch (e) {
      print("SubMeal silinirken hata oluştu: $e");
    } finally {
      // SubMeals'ı tekrar yükleyerek UI'ı güncelle
      await _loadSubMeals();
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskMealsProvider = Provider.of<TasksMealsProvider>(context);
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
                                style: kCardTitleTextStyle(context),
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
                                subMealTitles: _subtitles,
                                onDelete: (p0, p1) {
                                  _deleteSubMeal(widget.meals.id, p1); // Burada silme işlemi çağrılıyor
                                },
                              ),
                              SubItemTextField(
                                controller: _subtitleController,
                                onSubmitted: (p0) {
                                  taskMealsProvider.addSubMeal(widget.meals, _subtitleController.text);
                                  _loadSubMeals();
                                  _subtitleController.clear();
                                },
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
