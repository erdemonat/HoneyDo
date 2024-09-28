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
        selectionShape: DateRangePickerSelectionShape.rectangle,
        yearCellStyle: DateRangePickerYearCellStyle(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          todayTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        monthCellStyle: DateRangePickerMonthCellStyle(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          todayTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        selectionRadius: 20,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectionTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
        ),
        headerStyle: const DateRangePickerHeaderStyle(
          backgroundColor: Colors.transparent,
        ),
        view: DateRangePickerView.month,
        monthViewSettings: const DateRangePickerMonthViewSettings(
          viewHeaderStyle: DateRangePickerViewHeaderStyle(
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          firstDayOfWeek: 1,
          weekendDays: <int>[DateTime.saturday, DateTime.sunday],
        ),
      ),
    );
  }
}
