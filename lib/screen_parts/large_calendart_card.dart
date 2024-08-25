import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LargeCalendartCard extends StatelessWidget {
  const LargeCalendartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SfDateRangePicker(
        onSelectionChanged: (dateRangePickerSelectionChangedArgs) {},
        selectionMode: DateRangePickerSelectionMode.single,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectionTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
        ),
        headerStyle: const DateRangePickerHeaderStyle(
            backgroundColor: Colors.transparent),
        view: DateRangePickerView.month,
        monthViewSettings: const DateRangePickerMonthViewSettings(
            dayFormat: 'E',
            firstDayOfWeek: 1,
            weekendDays: <int>[DateTime.saturday, DateTime.monday]),
      ),
    );
  }
}
