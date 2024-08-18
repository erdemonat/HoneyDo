import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

bool _isHorizontalOrientation = false;
Widget _buildTextLabels(BuildContext context) {
  final Brightness brightness = Theme.of(context).brightness;
  const double deliveryStatus = 20;
  const double orderState = 0;
  const double packedState = 10;
  const double shippedState = 20;
  const double deliveredState = 30;
  const Color activeColor =
      deliveryStatus > orderState ? Color(0xff0DC9AB) : Color(0xffD1D9DD);
  final Color inactiveColor = brightness == Brightness.dark
      ? const Color(0xff62686A)
      : const Color(0xFFD1D9DD);

  return SizedBox(
      height: _isHorizontalOrientation ? 100 : 300,
      child: SfLinearGauge(
        orientation: _isHorizontalOrientation
            ? LinearGaugeOrientation.horizontal
            : LinearGaugeOrientation.vertical,
        maximum: 30,
        labelOffset: 24,
        isAxisInversed: !_isHorizontalOrientation,
        showTicks: false,
        onGenerateLabels: () {
          return <LinearAxisLabel>[
            const LinearAxisLabel(text: 'Ordered', value: 0),
            const LinearAxisLabel(text: 'Packed', value: 10),
            const LinearAxisLabel(text: 'Shipped', value: 20),
            const LinearAxisLabel(text: 'Delivered', value: 30),
          ];
        },
        axisTrackStyle: LinearAxisTrackStyle(
          color: inactiveColor,
        ),
        barPointers: const <LinearBarPointer>[
          LinearBarPointer(
            value: deliveryStatus,
            color: activeColor,
            enableAnimation: false,
          ),
        ],
        markerPointers: <LinearMarkerPointer>[
          LinearWidgetPointer(
            value: orderState,
            enableAnimation: false,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border.all(width: 4, color: activeColor),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: const Center(
                child: Icon(Icons.check_rounded, size: 14, color: activeColor),
              ),
            ),
          ),
          LinearWidgetPointer(
            enableAnimation: false,
            value: packedState,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(width: 4, color: activeColor),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: const Center(
                child: Icon(Icons.check_rounded, size: 14, color: activeColor),
              ),
            ),
          ),
          LinearWidgetPointer(
            value: shippedState,
            enableAnimation: false,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(width: 4, color: activeColor),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: const Center(
                child: Icon(Icons.check_rounded, size: 14, color: activeColor),
              ),
            ),
          ),
          LinearShapePointer(
            value: deliveredState,
            enableAnimation: false,
            color: inactiveColor,
            width: 24,
            height: 24,
            position: LinearElementPosition.cross,
            shapeType: LinearShapePointerType.circle,
          ),
        ],
      ));
}
