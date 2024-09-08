import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
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
  late Duration remainingPomodoroDuration;
  String currentPhase = "Pomodoro";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0), // Default to 0
    )
      ..addListener(_updateRemainingDuration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) onTimerComplete();
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Initialize pomodoroProvider here after the widget is attached to the tree
    pomodoroProvider = Provider.of<PomodoroProvider>(context);

    // Set initial durations and values based on pomodoroProvider
    remainingPomodoroDuration = pomodoroProvider.pomodoroDuration;
    _controller.duration = pomodoroProvider.pomodoroDuration;
  }

  void _updateRemainingDuration() {
    setState(() {
      remainingPomodoroDuration = Duration(
        seconds:
            (getCurrentDuration().inSeconds * (1 - _controller.value)).round(),
      );
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
    if (currentPhase == "Pomodoro" && currentSet < pomodoroProvider.setCount) {
      _updatePhase("Short Break", "Kısa Mola");
    } else if (currentPhase == "Pomodoro") {
      _updatePhase("Long Break", "Uzun Mola");
    } else if (currentPhase == "Short Break") {
      _updatePhase("Pomodoro", "Pomodoro", incrementSet: true);
    } else {
      resetTimer();
    }
  }

  void _updatePhase(String phase, String status, {bool incrementSet = false}) {
    setState(() {
      currentPhase = phase;
      pomodoroStatus = status;
      if (incrementSet) currentSet++;
    });
    _controller.duration = getCurrentDuration();
    _controller.reset();
    _controller.forward();
  }

  void skipPhase() {
    onTimerComplete();
    setState(() => _isPlay = true);
  }

  void startTimer() {
    setState(() {
      _isPlay = true;
      _controller.duration = remainingPomodoroDuration;
      _controller.forward(
        from: 1.0 -
            (remainingPomodoroDuration.inSeconds /
                getCurrentDuration().inSeconds),
      );
    });
  }

  void pauseTimer() {
    setState(() => _isPlay = false);
    _controller.stop();
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
    _isPlay ? pauseTimer() : startTimer();
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

    return buildCardUI(settingsProvider);
  }

  Widget buildCardUI(SettingsProvider settingsProvider) {
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
          buildTimerUI(),
          const SizedBox(height: 20),
          buildSetCounter(),
          const SizedBox(height: 20),
          Text(pomodoroStatus, style: kPomodoroStatusTextStyle(context)),
          const SizedBox(height: 20),
          buildControlButtons(),
          const SizedBox(height: 20),
          buildSettingsAndResetButtons(settingsProvider),
        ],
      ),
    );
  }

  Widget buildTimerUI() {
    return SizedBox(
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
                fontSize: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSetCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pomodoroProvider.setCount, (index) {
        int setNumber = index + 1;
        bool isCurrent = setNumber == currentSet;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            setNumber.toString(),
            style: TextStyle(
              fontSize: isCurrent ? 20 : 18,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        );
      }),
    );
  }

  Widget buildControlButtons() {
    return Row(
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
          onPressed: skipPhase,
          icon: const Icon(Icons.skip_next_rounded),
        ),
      ],
    );
  }

  Widget buildSettingsAndResetButtons(SettingsProvider settingsProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            _showResetConfirmationDialog();
          },
          icon: const Icon(Icons.refresh_rounded),
        ),
        IconButton(
          onPressed: () {
            settingsProvider.toggleSettingsCard();
          },
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }

  void _showResetConfirmationDialog() {
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
  }
}
