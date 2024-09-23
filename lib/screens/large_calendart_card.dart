import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LargeCalendartCard extends StatelessWidget {
  final void Function(DateRangePickerSelectionChangedArgs) onSelectionChanged;

  const LargeCalendartCard({super.key, required this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 400,
      child: SfDateRangePicker(
        showNavigationArrow: true,
        onSelectionChanged: onSelectionChanged,
        selectionMode: DateRangePickerSelectionMode.single,
        todayHighlightColor: Theme.of(context).colorScheme.tertiary,
        selectionColor: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectionTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
        ),
        headerStyle: const DateRangePickerHeaderStyle(
          backgroundColor: Colors.transparent,
        ),
        view: DateRangePickerView.month,
        monthViewSettings: const DateRangePickerMonthViewSettings(
          firstDayOfWeek: 1,
          weekendDays: <int>[
            DateTime.saturday,
            DateTime.sunday
          ],
        ),
      ),
    );
  }
}
