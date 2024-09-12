import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/providers/focus_date_provider.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
import 'package:honeydo/screens/large_calendart_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalenderCard extends StatefulWidget {
  const CalenderCard({super.key});

  @override
  State<CalenderCard> createState() => _CalenderCardState();
}

final EasyInfiniteDateTimelineController _controller = EasyInfiniteDateTimelineController();
DateTime now = DateTime.now();
DateTime firstDate = DateTime(1900);
DateTime lastDate = DateTime(2100);

class _CalenderCardState extends State<CalenderCard> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double widthContainerSize = screenWidth * 0.045;
    final double heightContainerSize = screenHeight * 0.085;
    final double paddingSize = screenWidth * 0.02;

    final focusDateModel = Provider.of<FocusDateProvider>(context, listen: false);
    final tasksMealsProvider = Provider.of<TasksMealsProvider>(context, listen: false);

    return Row(
      children: [
        Container(
          width: widthContainerSize,
          height: double.infinity,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  VoidCallback;
                  setState(() {
                    focusDateModel.updateFocusDate(now);
                    _controller.animateToDate(
                      focusDateModel.focusDate,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  });
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: screenWidth * 0.024,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Divider(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: SizedBox(
                        height: 250,
                        width: 400,
                        child: LargeCalendartCard(
                          onSelectionChanged: (args) {
                            setState(() {
                              focusDateModel.updateFocusDate(args.value as DateTime);
                              _controller.animateToDate(
                                focusDateModel.focusDate,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.date_range_rounded,
                  size: screenWidth * 0.024,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EasyInfiniteDateTimeLine(
                dayProps: EasyDayProps(width: 125, height: screenHeight * 0.14),
                itemBuilder: (context, date, isSelected, onTap) {
                  final dayName = DateFormat('EE', 'tr_TR').format(date);
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: onTap,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dayName,
                            style: isSelected ? kCalendarDayTextStyle(context) : null,
                          ),
                          Text(
                            date.day.toString(),
                            style: isSelected ? kCalendarDayNumberTextStyle(context) : kCalendarDayNumberTextStyle(context),
                          ),
                          if (isSelected)
                            Text(
                              DateFormat('MMMM yyyy', 'tr_TR').format(focusDateModel.focusDate),
                              style: kCalendarDayTextStyle(context),
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
                focusDate: focusDateModel.focusDate,
                lastDate: lastDate,
                onDateChange: (selectedDate) {
                  setState(
                    () {
                      focusDateModel.updateFocusDate(selectedDate);
                      tasksMealsProvider.loadTasks(context);
                      tasksMealsProvider.loadMeals(context);
                    },
                  );
                },
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(top: 0.01 * screenHeight),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Theme.of(context).colorScheme.surface),
                  child: Center(
                    child: Text(
                      "Upcoming",
                      style: kCalendarMonthYearTextStyle(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
