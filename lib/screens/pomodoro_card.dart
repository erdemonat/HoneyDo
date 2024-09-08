import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:honeydo/providers/pomodoro_provider.dart';
import 'package:honeydo/providers/settings_provider.model.dart';

class PomodoroCard extends StatefulWidget {
  const PomodoroCard({super.key});

  @override
  State<PomodoroCard> createState() => _PomodoroCardState();
}

class _PomodoroCardState extends State<PomodoroCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late PomodoroProvider pomodoroProvider;
  String pomodoroStatus = "Hazır";
  bool _isPlay = false;
  int currentSet = 1;

  Duration remainingPomodoroDuration = const Duration(minutes: 25);
  String currentPhase = "Pomodoro";

  @override
  void initState() {
    super.initState();
    pomodoroProvider = Provider.of<PomodoroProvider>(context, listen: false);
    remainingPomodoroDuration = pomodoroProvider.pomodoroDuration;
    _controller = AnimationController(
      vsync: this,
      duration: pomodoroProvider.pomodoroDuration,
    )
      ..addListener(() {
        setState(() {
          remainingPomodoroDuration = Duration(
              seconds:
                  (getCurrentDuration().inSeconds * (1 - _controller.value))
                      .round());
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          onTimerComplete();
        }
      });
  }

  Duration getCurrentDuration() {
    switch (currentPhase) {
      case "Short Break":
        return pomodoroProvider.shortBreakDuration;
      case "Long Break":
        return pomodoroProvider.longBreakDuration;
      default:
        return pomodoroProvider.pomodoroDuration;
    }
  }

  void onTimerComplete() {
    switch (currentPhase) {
      case "Pomodoro":
        if (currentSet < pomodoroProvider.setCount) {
          setState(() {
            currentPhase = "Short Break";
            pomodoroStatus = "Kısa Mola";
          });
        } else {
          setState(() {
            currentPhase = "Long Break";
            pomodoroStatus = "Uzun Mola";
          });
        }
        break;
      case "Short Break":
        setState(() {
          currentSet++;
          currentPhase = "Pomodoro";
          pomodoroStatus = "Pomodoro";
        });
        break;
      case "Long Break":
        resetTimer();
        return;
    }
    _controller.duration = getCurrentDuration();
    _controller.reset();
    _controller.forward();
  }

  void skipPhase() {
    setState(() {
      onTimerComplete();
      _isPlay = true;
    });
  }

  void startTimer() {
    setState(() {
      _isPlay = true;
      _controller.duration = remainingPomodoroDuration;
      _controller.forward(
          from: 1.0 -
              (remainingPomodoroDuration.inSeconds /
                  getCurrentDuration().inSeconds));
    });
  }

  void pauseTimer() {
    setState(() {
      _isPlay = false;
      _controller.stop();
    });
  }

  void resetTimer() {
    _controller.reset();
    setState(() {
      _isPlay = false;
      currentSet = 1;
      currentPhase = "Pomodoro";
      pomodoroStatus = "Hazır";
      remainingPomodoroDuration = pomodoroProvider.pomodoroDuration;
    });
  }

  void playPauseTimer() {
    if (_isPlay) {
      pauseTimer();
    } else {
      startTimer();
    }
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 180,
              height: 180,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Transform.flip(
                    flipX: true,
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      strokeWidth: 10,
                      strokeCap: StrokeCap.round,
                      value: 1.0 - _controller.value,
                    ),
                  ),
                  Center(
                    child: Text(
                      timerText,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 32),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pomodoroProvider.setCount, (index) {
                int setNumber = index + 1;
                bool isCurrent = setNumber == currentSet;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    setNumber.toString(),
                    style: isCurrent
                        ? TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary)
                        : TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_previous_rounded),
                ),
                IconButton(
                  onPressed: playPauseTimer,
                  icon: Icon(
                    _isPlay ? Icons.pause : Icons.play_arrow_rounded,
                    size: 62,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      skipPhase();
                    },
                    icon: const Icon(Icons.skip_next_rounded)),
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
                          title: const Text('Emin misiniz?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                resetTimer();
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
                    settingsProvider.toggleSettingsCard();
                  },
                  icon: const Icon(Icons.settings),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
