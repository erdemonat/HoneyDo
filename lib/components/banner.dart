import 'dart:async';
import 'package:flutter/material.dart';

class HoneydoBanner extends StatefulWidget {
  const HoneydoBanner({super.key});

  @override
  HoneydoBannerState createState() => HoneydoBannerState();
}

class HoneydoBannerState extends State<HoneydoBanner> {
  late Timer _timer;
  String _currentWeatherTitle = '31 °C';
  int _weatherTitleIndex = 0;
  final List<String> _weatherTitles = [
    '31 °C',
    'Hava Bulutlu',
    'Rüzgar: 10 km/h',
    'Nem: 60%',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        _weatherTitleIndex = (_weatherTitleIndex + 1) % _weatherTitles.length;
        _currentWeatherTitle = _weatherTitles[_weatherTitleIndex];
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(
              Icons.donut_small_sharp,
              size: 18,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 6),
          RichText(
            text: TextSpan(
              text: 'Honey',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurface),
              children: <TextSpan>[
                TextSpan(
                  text: 'Do',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 4),
            child: VerticalDivider(
              thickness: 0.5,
            ),
          ),
          Icon(
            Icons.cloudy_snowing,
            size: 18,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              _currentWeatherTitle,
              style: const TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}