import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/components/rotate_animated_text.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
import 'package:provider/provider.dart';

class UpcomingEventCard extends StatefulWidget {
  const UpcomingEventCard({
    super.key,
  });

  @override
  State<UpcomingEventCard> createState() => _UpcomingEventCardState();
}

class _UpcomingEventCardState extends State<UpcomingEventCard> {
  late final TasksMealsProvider tasksMealsProvider =
      Provider.of<TasksMealsProvider>(context, listen: false);
  bool _isDelayed = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TasksMealsProvider>(context, listen: false)
          .loadUpcomingEvents();
    });

    // Gecikmeyi burada ayarlıyoruz
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isDelayed = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: _isDelayed
          ? Center(
              child: tasksMealsProvider.upcomingEvents.isNotEmpty
                  ? AnimatedTextKit(
                      animatedTexts: [
                        for (int i = 0;
                            i < tasksMealsProvider.upcomingEvents.length;
                            i++)
                          CustomRotateAnimatedText(
                            tasksMealsProvider.upcomingEvents[i],
                            textStyle: kCalendarMonthYearTextStyle(context),
                          ),
                      ],
                      onFinished: () {
                        setState(() {
                          // Animasyon bittiğinde başka bir işlem yapmak istersen buraya ekleyebilirsin
                        });
                      },
                      repeatForever:
                          false, // Animasyonun tekrar etmesini istemiyorsak false yapıyoruz
                    )
                  : const Text(''),
            )
          : const SizedBox(),
    );
  }
}
