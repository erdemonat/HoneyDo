import 'dart:async';

import 'package:flutter/material.dart';
import 'package:honeydo/components/settings_sheet.dart';

class PomodoroCard extends StatefulWidget {
  const PomodoroCard({super.key});

  @override
  State<PomodoroCard> createState() => _PomodoroCardState();
}
// int set, duration pomodorotime, duration shortbreak, duration longbreak, bool autoStartPomodoro, bool autoStartbreak
// 3 void start pause reset
//

class _PomodoroCardState extends State<PomodoroCard> {
  String pomodoroStatus = "Hazır";
  bool _isPlay = false;
  bool autoStartPomodoro = false;
  bool autoStartBreak = false;
  int selectedSet = 4;
  int currentSet = 0;
  late Timer _timer;
  static const Duration pomodoroDuration = Duration(minutes: 25);
  Duration remainingPomodoroDuration = pomodoroDuration;
  Duration shortBreakDuration = const Duration(seconds: 2);
  Duration longBreakDuration = const Duration(seconds: 3);

  void pomodoroTimer() {
    pomodoroStatus = "Pomodoro";
    currentSet++;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          if (remainingPomodoroDuration.inSeconds == 0) {
            _timer.cancel();
          } else if (_isPlay) {
            remainingPomodoroDuration =
                remainingPomodoroDuration - const Duration(seconds: 1);
          }
        });
      },
    );
  }

  void playPauseTimer() {
    setState(() {
      _isPlay = !_isPlay;
      if (_isPlay) {
        pomodoroTimer();
      } else {
        _timer.cancel();
      }
    });
  }

  void resetPomodoro() {
    playPauseTimer();
    setState(() {
      _isPlay = false;
      pomodoroStatus = "Hazır";
      currentSet = 0;
      remainingPomodoroDuration = pomodoroDuration;
    });
  }

  String get timerText {
    final minutes =
        remainingPomodoroDuration.inMinutes.toString().padLeft(2, '0');
    final seconds =
        (remainingPomodoroDuration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            radius: 120,
            child: Text(
              timerText,
              style: const TextStyle(color: Colors.white, fontSize: 32),
            ),
          ),
          Text(
            pomodoroStatus,
            style: TextStyle(fontSize: 24),
          ),
          Text(currentSet.toString()),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.skip_previous_rounded)),
              IconButton(
                onPressed: playPauseTimer,
                icon: Icon(
                  _isPlay ? Icons.pause : Icons.play_arrow_rounded,
                  size: 62,
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.skip_next_rounded)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Emin misan?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              resetPomodoro();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Evet'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('İptal'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.refresh_rounded)),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          heightFactor: 0.9,
                          widthFactor: 0.3,
                          child: Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: SettingsSheet(),
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          )
        ],
      ),
    );
  }
}
