import 'dart:async';
import 'package:flutter/material.dart';
import 'package:honeydo/providers/weather_provider.dart';
import 'package:provider/provider.dart';

class HoneydoBanner extends StatefulWidget {
  const HoneydoBanner({super.key});

  @override
  HoneydoBannerState createState() => HoneydoBannerState();
}

class HoneydoBannerState extends State<HoneydoBanner>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  String _currentWeatherTitle = '';
  int _weatherTitleIndex = 0;
  late Animation<double> _fadeIn, _fadeOut;
  late AnimationController _controller;
  late final List<String> _weatherTitles =
      Provider.of<WeatherProvider>(context, listen: false).weatherTitle;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    );

    _initAnimations();
    Future.microtask(() {
      final weatherProvider =
          Provider.of<WeatherProvider>(context, listen: false);
      weatherProvider.loadSavedCity(context);
      weatherProvider.updateWeatherData(repeat: true);
    });

    _controller.forward();
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      setState(() {
        _weatherTitleIndex = (_weatherTitleIndex + 1) % _weatherTitles.length;
        _currentWeatherTitle = _weatherTitles[_weatherTitleIndex];
      });
      _controller.forward(from: 0);
    });
  }

  void _initAnimations() {
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.14, curve: Curves.easeOut),
      ),
    );

    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.86, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);

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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
            child: VerticalDivider(
              thickness: 0.5,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          weatherProvider.getWeatherIcon(context, weatherProvider.iconCode),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity:
                      _fadeIn.value != 1.0 ? _fadeIn.value : _fadeOut.value,
                  child: Text(
                    _currentWeatherTitle,
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
