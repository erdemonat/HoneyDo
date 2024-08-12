import 'package:flutter/material.dart';
import 'package:honeydo/components/build_step.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      orientation: LinearGaugeOrientation.horizontal,
      majorTickStyle: LinearTickStyle(length: 0),
      axisTrackStyle: LinearAxisTrackStyle(
        thickness: 4,
        edgeStyle: LinearEdgeStyle.bothCurve,
        color: Colors.grey[300],
      ),
      markerPointers: <LinearMarkerPointer>[
        LinearWidgetPointer(
          value: 0,
          position: LinearElementPosition.outside,
          child: buildStep(1, 'Ordered', isActive: true),
        ),
        LinearWidgetPointer(
          value: 33.3,
          position: LinearElementPosition.outside,
          child: buildStep(2, 'Packed', isActive: true),
        ),
        LinearWidgetPointer(
          value: 66.6,
          position: LinearElementPosition.outside,
          child: buildStep(3, 'Shipped', isActive: true),
        ),
        LinearWidgetPointer(
          value: 100,
          position: LinearElementPosition.outside,
          child: buildStep(4, 'Delivered', isActive: false),
        ),
      ],
    );
  }
}
