import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

class CalenderCard extends StatefulWidget {
  const CalenderCard({super.key});

  @override
  State<CalenderCard> createState() => _CalenderCardState();
}

class _CalenderCardState extends State<CalenderCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.date_range_rounded),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EasyInfiniteDateTimeLine(
                    physics: const NeverScrollableScrollPhysics(),
                    showTimelineHeader: false,
                    locale: "tr_TR",
                    controller: EasyInfiniteDateTimelineController(),
                    firstDate: DateTime(2023),
                    focusDate: DateTime(2023, 12, 31),
                    lastDate: DateTime(2023, 12, 31),
                    onDateChange: (selectedDate) {
                      setState(
                        () {
                          //_focusDate = selectedDate;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
