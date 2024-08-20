import 'package:flutter/material.dart';
import 'package:honeydo/components/pomodoro_components/settings_sheet.dart';

class PomodoroCard extends StatefulWidget {
  const PomodoroCard({super.key});

  @override
  State<PomodoroCard> createState() => _PomodoroCardState();
}

class _PomodoroCardState extends State<PomodoroCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String pomodoroStatus = "Hazır";
  bool _isPlay = false;
  int selectedSet = 4;
  int currentSet = 1;

  static Duration pomodoroDuration = const Duration(minutes: 25);
  static Duration shortBreakDuration = const Duration(minutes: 5);
  static Duration longBreakDuration = const Duration(minutes: 15);

  Duration remainingPomodoroDuration = pomodoroDuration;

  String currentPhase = "Pomodoro";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: pomodoroDuration,
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
        return shortBreakDuration;
      case "Long Break":
        return longBreakDuration;
      default:
        return pomodoroDuration;
    }
  }

  void onTimerComplete() {
    switch (currentPhase) {
      case "Pomodoro":
        if (currentSet < selectedSet) {
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
      remainingPomodoroDuration = pomodoroDuration;
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
                      style: const TextStyle(color: Colors.white, fontSize: 32),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(selectedSet, (index) {
                int setNumber = index + 1;
                bool isCurrent = setNumber == currentSet;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    setNumber.toString(),
                    style: isCurrent
                        ? const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                        : TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white.withOpacity(0.5),
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
                          title: const Text('Emin misan?'),
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
                              child: SettingsSheet(
                                userPomodoroDuration:
                                    pomodoroDuration.inMinutes,
                                userShortBreakDuration:
                                    shortBreakDuration.inMinutes,
                                userLongBreakDuration:
                                    longBreakDuration.inMinutes,
                                userSetCount: selectedSet,
                                onSettingsChanged: (int pomodoro,
                                    int shortBreak,
                                    int longBreak,
                                    int setCount,
                                    bool autoShortBreak,
                                    bool autoPomodoro) {
                                  setState(() {
                                    pomodoroDuration =
                                        Duration(minutes: pomodoro);
                                    shortBreakDuration =
                                        Duration(minutes: shortBreak);
                                    longBreakDuration =
                                        Duration(minutes: longBreak);
                                    selectedSet = setCount;

                                    if (currentSet > selectedSet) {
                                      currentSet = 1;
                                    }

                                    remainingPomodoroDuration =
                                        getCurrentDuration();
                                    _controller.duration =
                                        remainingPomodoroDuration;
                                  });
                                },
                              ),
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
      ),
    );
  }
}
