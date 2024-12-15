import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProgressBar extends StatelessWidget {
  final int subTaskLength;
  final int completedTasks;
  final bool isTaskChecked;

  const ProgressBar({
    super.key,
    required this.subTaskLength,
    required this.completedTasks,
    required this.isTaskChecked,
  });

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    Color activeColor = Theme.of(context).colorScheme.tertiary;
    final Color inactiveColor = brightness == Brightness.dark
        ? Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5)
        : Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5);

    List<LinearMarkerPointer> markerPointers = [];

    double stepValue = subTaskLength > 0 ? 100 / subTaskLength : 100.0;

    if (subTaskLength > 0) {
      markerPointers.add(
        LinearWidgetPointer(
          value: 0,
          enableAnimation: false,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(
                  width: 4,
                  color: completedTasks > 0 ? activeColor : inactiveColor),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Center(
              child: completedTasks > 0
                  ? Icon(Icons.check_rounded, size: 14, color: activeColor)
                  : const SizedBox(),
            ),
          ),
        ),
      );
    }

    for (int i = 1; i < subTaskLength; i++) {
      double pointerValue = i * stepValue;

      markerPointers.add(
        LinearWidgetPointer(
          value: pointerValue,
          enableAnimation: false,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(
                  width: 4,
                  color: i < completedTasks ? activeColor : inactiveColor),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Center(
              child: i < completedTasks
                  ? Icon(Icons.check_rounded, size: 14, color: activeColor)
                  : const SizedBox(),
            ),
          ),
        ),
      );
    }

    markerPointers.add(
      LinearWidgetPointer(
        value: (subTaskLength != 0) ? 100 : 50,
        enableAnimation: false,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            border: Border.all(
                width: 4, color: isTaskChecked ? activeColor : inactiveColor),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Center(
            child: isTaskChecked
                ? Icon(Icons.check_rounded, size: 14, color: activeColor)
                : const SizedBox(),
          ),
        ),
      ),
    );

    return SizedBox(
      width: 50,
      height: double.infinity,
      child: SfLinearGauge(
        orientation: LinearGaugeOrientation.vertical,
        maximum: 100,
        showLabels: false,
        showTicks: false,
        axisTrackStyle: LinearAxisTrackStyle(
          color: (subTaskLength != 0) ? inactiveColor : Colors.transparent,
        ),
        barPointers: <LinearBarPointer>[
          LinearBarPointer(
            value: completedTasks * stepValue,
            color: activeColor,
            enableAnimation: false,
          ),
        ],
        markerPointers: markerPointers,
      ),
    );
  }
}
