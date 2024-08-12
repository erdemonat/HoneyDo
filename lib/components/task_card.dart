import 'package:flutter/material.dart';
import 'package:honeydo/components/build_step.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TaskCard extends StatefulWidget {
  TaskCard({
    super.key,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isExpanded = false;
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: isExpanded ? 120 : 60,
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Card(
          color: Color(0xff1c1f26),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                    ),
                    Text(
                      'Evi temizle',
                      style: TextStyle(fontSize: 18),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        width: 300,
                        height: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SfLinearGauge(
                            showTicks: false,
                            showLabels: false,
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
                                child:
                                    buildStep(4, 'Delivered', isActive: false),
                              ),
                            ],
                            ranges: [
                              LinearGaugeRange(
                                edgeStyle: LinearEdgeStyle.bothCurve,
                                rangeShapeType: LinearRangeShapeType.curve,
                                startValue: 0,
                                endValue: 50,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (isExpanded)
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("• ", style: TextStyle(fontSize: 24)),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isComplete = !isComplete;
                              });
                              (print("object"));
                            },
                            child: Text(
                              "Odayı Temizle",
                              style: TextStyle(
                                decoration: isComplete
                                    ? TextDecoration.none
                                    : TextDecoration.lineThrough,
                                decorationThickness: 14,
                                decorationColor:
                                    Color.fromARGB(62, 255, 79, 79),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
