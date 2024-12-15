import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WeatherIcon extends StatefulWidget {
  final String iconCode;

  const WeatherIcon({
    super.key,
    required this.iconCode,
  });

  @override
  WeatherIconState createState() => WeatherIconState();
}

class WeatherIconState extends State<WeatherIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SvgPicture.asset(
        'assets/weather_icons/${widget.iconCode}.svg',
        width: 22,
        height: 22,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onSurface,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
