import 'dart:async';
import 'package:flutter/material.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
import 'package:provider/provider.dart';

class UpcomingEventCard extends StatefulWidget {
  const UpcomingEventCard({
    super.key,
  });

  @override
  State<UpcomingEventCard> createState() => _UpcomingEventCardState();
}

class _UpcomingEventCardState extends State<UpcomingEventCard>
    with SingleTickerProviderStateMixin {
  late final TasksMealsProvider tasksMealsProvider =
      Provider.of<TasksMealsProvider>(context, listen: false);

  bool _isDelayed = false;
  int _currentEventIndex = 0;
  Timer? _timer;
  late AnimationController _controller;
  late Animation<double> _fadeIn, _fadeOut;
  late Animation<Alignment> _slideIn, _slideOut;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7), // Total animation duration
    );

    _initAnimations();

    Future.microtask(() {
      tasksMealsProvider.loadUpcomingEvents();
    });

    // Delay for 3 seconds before showing content
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isDelayed = true;
      });
      _startEventRotation();
    });
  }

  void _initAnimations() {
    // Fade-in animation (first 1 second)
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.14, curve: Curves.easeOut),
      ),
    );

    // Slide-in animation (first 1 second)
    _slideIn = AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.center,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.14, curve: Curves.easeOut),
      ),
    );

    // Fade-out animation (last 1 second)
    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.86, 1.0, curve: Curves.easeIn),
      ),
    );

    // Slide-out animation (last 1 second)
    _slideOut = AlignmentTween(
      begin: Alignment.center,
      end: Alignment.bottomCenter,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.86, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  void _startEventRotation() {
    if (tasksMealsProvider.upcomingEvents.isEmpty) return;

    // Start the initial animation
    _controller.forward();

    // After every 7 seconds, move to the next event
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      setState(() {
        // Move to the next event
        _currentEventIndex =
            (_currentEventIndex + 1) % tasksMealsProvider.upcomingEvents.length;
      });
      _controller.forward(from: 0); // Restart the animation for the next event
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: _isDelayed
          ? Center(
              child: tasksMealsProvider.upcomingEvents.isNotEmpty
                  ? AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeIn.value != 1.0
                              ? _fadeIn.value
                              : _fadeOut.value,
                          child: Align(
                              alignment: _slideIn.value != Alignment.center
                                  ? _slideIn.value
                                  : _slideOut.value,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: tasksMealsProvider
                                          .upcomingEvents[_currentEventIndex]
                                          .split(' ')
                                          .first,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' ${tasksMealsProvider.upcomingEvents[_currentEventIndex].split(' ').skip(1).join(' ')}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      },
                    )
                  : const Text(''),
            )
          : const SizedBox(),
    );
  }
}
