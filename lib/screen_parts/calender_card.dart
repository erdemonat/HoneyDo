import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/components/constants.dart';
import 'package:intl/intl.dart';

class CalenderCard extends StatefulWidget {
  const CalenderCard({super.key});

  @override
  State<CalenderCard> createState() => _CalenderCardState();
}

final EasyInfiniteDateTimelineController _controller =
    EasyInfiniteDateTimelineController();
DateTime now = DateTime.now();
DateTime _focusDate = DateTime.now();
DateTime firstDate = now.subtract(const Duration(days: 15));
DateTime lastDate = now.add(const Duration(days: 15));

class _CalenderCardState extends State<CalenderCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
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
                    onPressed: () {
                      VoidCallback;
                      setState(() {
                        _focusDate = now;
                        _controller.animateToDate(
                          _focusDate,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
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
                    dayProps: const EasyDayProps(width: 125),
                    itemBuilder: (context, date, isSelected, onTap) {
                      final dayName = DateFormat('EEEE', 'tr_TR').format(date);
                      return InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: onTap,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dayName,
                                style: isSelected
                                    ? calendarDayTextStyle(context)
                                    : null,
                              ),
                              Text(
                                date.day.toString(),
                                style: calendarDayNumberTextStyle(context),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    showTimelineHeader: false,
                    locale: "tr_TR",
                    controller: _controller,
                    firstDate: firstDate,
                    focusDate: _focusDate,
                    lastDate: lastDate,
                    onDateChange: (selectedDate) {
                      setState(
                        () {
                          _focusDate = selectedDate;
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
