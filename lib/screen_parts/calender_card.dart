import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/components/constants.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/focus_date_model.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:honeydo/screen_parts/large_calendart_card.dart';
import 'package:honeydo/screen_parts/todo_tasks_card.dart';
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

Future<void> _createEmptyTaskDate(String taskDataName, String date) async {
  await isar.writeTxn(() async {
    HoneyDoData? honeyDoData = await getTaskDataByName(taskDataName);
    if (honeyDoData == null) {
      honeyDoData = HoneyDoData()..name = taskDataName;
      await isar.honeyDoDatas.put(honeyDoData);
    }
    DateLinks? dateLink = await getTaskDateByDate(honeyDoData, date);
    if (dateLink == null) {
      dateLink = DateLinks()..date = date;
      await isar.dateLinks.put(dateLink);
      honeyDoData.dateLinks.add(dateLink);
      await honeyDoData.dateLinks.save();
    }
    await dateLink.tasks.load();
  });
}

class _CalenderCardState extends State<CalenderCard> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double widthContainerSize = screenWidth * 0.045;
    final double heightContainerSize = screenHeight * 0.085;
    final double paddingSize = screenWidth * 0.02;

    final focusDateModel = Provider.of<FocusDateModel>(context);

    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: widthContainerSize,
              height: heightContainerSize,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: IconButton(
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
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
            ),
            Container(
              width: widthContainerSize,
              height: heightContainerSize,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: IconButton(
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
                              focusDateModel
                                  .updateFocusDate(args.value as DateTime);
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
                icon: const Icon(Icons.date_range_rounded),
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EasyInfiniteDateTimeLine(
                dayProps: const EasyDayProps(width: 125),
                itemBuilder: (context, date, isSelected, onTap) {
                  final dayName = DateFormat('EE', 'tr_TR').format(date);
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
                focusDate: focusDateModel.focusDate,
                lastDate: lastDate,
                onDateChange: (selectedDate) {
                  setState(
                    () {
                      focusDateModel.updateFocusDate(selectedDate);
                      _createEmptyTaskDate(
                        'HoneyDo Data',
                        DateFormat('ddMMyyyy').format(focusDateModel.focusDate),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                width: double.infinity,
                height: screenHeight * 0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.surface),
                child: Center(
                  child: Text(
                    "${DateFormat('MMMM yyyy', 'tr_TR').format(focusDateModel.focusDate)}",
                    style: calendarMonthYearTextStyle(context),
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
