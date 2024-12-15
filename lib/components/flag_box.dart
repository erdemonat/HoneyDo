import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/providers/language_provider.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
import 'package:honeydo/providers/weather_provider.dart';
import 'package:provider/provider.dart';

class FlagBox extends StatelessWidget {
  final int index;

  FlagBox({
    super.key,
    required this.index,
  });

  // for provider
  final List<String> flagPaths = [
    'assets/flags/de.svg',
    'assets/flags/us.svg',
    'assets/flags/es.svg',
    'assets/flags/fr.svg',
    'assets/flags/jp.svg',
    'assets/flags/kr.svg',
    'assets/flags/ru.svg',
    'assets/flags/tr.svg',
    'assets/flags/cn.svg',
  ];

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          languageProvider.changeLanguage(index);
          Provider.of<WeatherProvider>(context, listen: false).updateWeatherData(context);
          Provider.of<TasksMealsProvider>(context, listen: false).loadUpcomingEvents();
          isarService.saveLanguage(index);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface,
              width: 2,
            ),
            borderRadius: languageProvider.languageIndex == index ? BorderRadius.circular(8) : BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          height: 40,
          width: 40,
          child: ClipRRect(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            borderRadius: languageProvider.languageIndex == index ? BorderRadius.circular(8) : BorderRadius.circular(32),
            child: SvgPicture.asset(
              flagPaths[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
