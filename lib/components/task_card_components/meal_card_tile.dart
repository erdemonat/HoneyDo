import 'package:flutter/material.dart';
import 'package:honeydo/components/task_card_components/sub_item_text_field.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/components/task_card_components/meal_subtitle_list_tile.dart';
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
    Future.microtask(() {
      if (mounted) {
        final tasksMealsProvider =
            Provider.of<TasksMealsProvider>(context, listen: false);
        tasksMealsProvider.loadSubMeals(widget.meals);
      }
    });
  }

  @override
  void dispose() {
    _subtitleController.dispose();
    super.dispose();
  }

  Future<void> _deleteSubMeal(int mealId, String subtitleText) async {
    final tasksMealsProvider =
        Provider.of<TasksMealsProvider>(context, listen: false);
    try {
      await tasksMealsProvider.deleteSubMeal(mealId, subtitleText);
    } catch (e) {
      print("SubMeal silinirken hata oluştu: $e");
    } finally {}
    await tasksMealsProvider.loadSubMeals(widget.meals);
  }

  @override
  Widget build(BuildContext context) {
    final taskMealsProvider =
        Provider.of<TasksMealsProvider>(context, listen: false);

    final subMeals = taskMealsProvider.getSubMeals(widget.meals.id);

    _currentExpandedHeight =
        _expandedBaseHeight + subMeals.length * _subtitleHeightIncrement;
    if (_cardHeight > _collapsedHeight) {
      _cardHeight = _currentExpandedHeight;
    }
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
                                subMealTitles: subMeals,
                                onDelete: (p0, p1) {
                                  _deleteSubMeal(widget.meals.id, p1);
                                },
                              ),
                              SubItemTextField(
                                controller: _subtitleController,
                                onSubmitted: (p0) {
                                  taskMealsProvider.addSubMeal(
                                      widget.meals, _subtitleController.text);
                                  taskMealsProvider.loadSubMeals(widget.meals);
                                  _subtitleController.clear();
                                },
                                hintext: 'Öğün içeriği ekle',
                                paddingHorizontal: 1,
                                dotLenght: 160,
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
