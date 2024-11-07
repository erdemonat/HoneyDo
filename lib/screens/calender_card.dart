import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/providers/focus_date_provider.dart';
import 'package:honeydo/providers/language_provider.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
import 'package:honeydo/screens/large_calendart_card.dart';
import 'package:honeydo/screens/upcoming_events_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalenderCard extends StatefulWidget {
  const CalenderCard({super.key});

  @override
  State<CalenderCard> createState() => _CalenderCardState();
}

final EasyInfiniteDateTimelineController _controller =
    EasyInfiniteDateTimelineController();
DateTime now = DateTime.now();
DateTime firstDate = DateTime(1900);
DateTime lastDate = DateTime(2100);
bool isHovered = false;

class _CalenderCardState extends State<CalenderCard> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double widthContainerSize = screenWidth * 0.045;
    final focusDateProvider =
        Provider.of<FocusDateProvider>(context, listen: false);
    final tasksMealsProvider =
        Provider.of<TasksMealsProvider>(context, listen: true);

    return Row(
      children: [
        Container(
          width: widthContainerSize,
          height: double.maxFinite,
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
                  focusDateProvider.updateFocusDate(DateTime.now());
                  tasksMealsProvider.createEmptyTaskDate(
                      context, focusDateProvider.getFocusDate());
                  setState(() {
                    _controller.animateToDate(
                      focusDateProvider.focusDate,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  });
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: screenHeight * 0.030,
                ),
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      content: LargeCalendartCard(
                        onSelectionChanged: (args) {
                          focusDateProvider
                              .updateFocusDate(args.value as DateTime);
                          tasksMealsProvider.createEmptyTaskDate(
                              context, focusDateProvider.getFocusDate());
                          setState(() {
                            _controller.animateToDate(
                              focusDateProvider.focusDate,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.date_range_rounded,
                  size: screenHeight * 0.030,
                ),
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
                dayProps: const EasyDayProps(width: 125, height: 105),
                itemBuilder: (context, date, isSelected, onTap) {
                  return HoverableDayTile(
                    date: date,
                    isSelected: isSelected,
                    onTap: onTap,
                  );
                },
                physics: const NeverScrollableScrollPhysics(),
                showTimelineHeader: false,
                locale: "tr_TR",
                controller: _controller,
                firstDate: firstDate,
                focusDate: focusDateProvider.focusDate,
                lastDate: lastDate,
                onDateChange: (selectedDate) {
                  focusDateProvider.updateFocusDate(selectedDate);
                  tasksMealsProvider.createEmptyTaskDate(
                      context, focusDateProvider.getFocusDate());
                },
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(top: 0.01 * screenHeight),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.surface),
                  child: const UpcomingEventCard(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HoverableDayTile extends StatefulWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  HoverableDayTile(
      {required this.date, required this.isSelected, required this.onTap});

  @override
  _HoverableDayTileState createState() => _HoverableDayTileState();
}

class _HoverableDayTileState extends State<HoverableDayTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final focusDateProvider =
        Provider.of<FocusDateProvider>(context, listen: false);
    final LanguageProvider languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    final dayName = DateFormat('EE', languageProvider.getLanguageCode())
        .format(widget.date);

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: widget.isSelected
                ? Theme.of(context).colorScheme.secondary
                : isHovered
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                    : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dayName,
                style:
                    widget.isSelected ? kCalendarDayTextStyle(context) : null,
              ),
              Text(
                widget.date.day.toString(),
                style: widget.isSelected
                    ? kCalendarDayNumberTextStyle(context)
                    : kCalendarDayNumberTextStyle(context),
              ),
              if (widget.isSelected)
                Text(
                  DateFormat('MMMM yyyy', languageProvider.getLanguageCode())
                      .format(focusDateProvider.focusDate),
                  style: kCalendarDayTextStyle(context),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
