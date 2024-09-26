import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/providers/audio_player_provider.dart';
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
  String pomodoroStatus = "Pomodoro";
  bool _isPlay = false;
  int currentSet = 1;
  late Duration remainingPomodoroDuration;
  String currentPhase = "Pomodoro";
  late final SoundEffectProvider soundEffectProvider =
      Provider.of<SoundEffectProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    )
      ..addListener(_updateRemainingDuration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _onTimerComplete(true);
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pomodoroProvider = Provider.of<PomodoroProvider>(context);
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

  void _onTimerComplete(bool playSound) {
    if (currentPhase == "Pomodoro" && currentSet < pomodoroProvider.setCount) {
      _updatePhase("Short Break", "Kısa Mola",
          autoContinue: pomodoroProvider.autoBreak, playSound: playSound);
    } else if (currentPhase == "Pomodoro") {
      _updatePhase("Long Break", "Uzun Mola",
          autoContinue: pomodoroProvider.autoBreak, playSound: playSound);
    } else if (currentPhase == "Short Break") {
      _updatePhase("Pomodoro", "Pomodoro",
          incrementSet: true,
          autoContinue: pomodoroProvider.autoPomodoro,
          playSound: playSound);
    } else {
      _resetTimer(false);
    }
  }

  void _undoPhase() {
    if (currentPhase == "Pomodoro" && currentSet > 1) {
      _updatePhase("Short Break", "Kısa Mola", decrementSet: true);
    } else if (currentPhase == "Short Break") {
      _updatePhase("Pomodoro", "Pomodoro");
    } else if (currentPhase == "Long Break") {
      _updatePhase("Pomodoro", "Pomodoro");
    }
    _controller.stop();
    setState(() => _isPlay = false);
  }

  void _updatePhase(String phase, String status,
      {bool decrementSet = false,
      bool incrementSet = false,
      bool autoContinue = true,
      bool playSound = false}) {
    if (playSound) {
      soundEffectProvider.playSound(
          pomodoroStatus == 'Pomodoro' ? 'pianoIntro' : 'pianoOutro');
    }
    setState(() {
      currentPhase = phase;
      pomodoroStatus = status;
      if (incrementSet) currentSet++;
      if (decrementSet) currentSet--;
    });
    _controller.duration = getCurrentDuration();
    _controller.reset();
    if (autoContinue) {
      _controller.forward();
    } else {
      _pauseTimer();
    }
  }

  void _skipPhase() {
    _onTimerComplete(false);
    _controller.stop();
    setState(() => _isPlay = false);
  }

  void _startTimer() {
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

  void _pauseTimer() {
    setState(() => _isPlay = false);
    _controller.stop();
  }

  void _resetTimer(bool resetSet) {
    _controller.reset();
    setState(() {
      _isPlay = false;
      if (resetSet) {
        currentSet = 1;
        currentPhase = "Pomodoro";
        pomodoroStatus = "Pomodoro";
        remainingPomodoroDuration = pomodoroProvider.pomodoroDuration;
      }
    });
  }

  void _playPauseTimer() {
    _isPlay ? _pauseTimer() : _startTimer();
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
    return _buildCardUI(settingsProvider);
  }

  Widget _buildCardUI(SettingsProvider settingsProvider) {
    final double screenHeight = MediaQuery.of(context).size.height;
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
          Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.08,
                left: screenHeight * 0.001,
                right: screenHeight * 0.001),
            child: Column(
              children: [
                _buildTimerUI(),
                SizedBox(height: screenHeight * 0.05),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSetCounter(),
                    SizedBox(height: screenHeight * 0.01),
                    Text(pomodoroStatus,
                        style: TextStyle(fontSize: screenHeight * 0.025)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(flex: 1, child: _buildControlButtons()),
          _buildSettingsAndResetButtons(settingsProvider),
        ],
      ),
    );
  }

  Widget _buildTimerUI() {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenHeight * 0.20,
      height: screenHeight * 0.20,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Transform.flip(
            flipX: true,
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).colorScheme.primary,
              color: Theme.of(context).colorScheme.inversePrimary,
              strokeWidth: screenHeight * 0.009,
              strokeCap: StrokeCap.round,
              value: 1.0 - _controller.value,
            ),
          ),
          Center(
            child: Text(
              timerText,
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: screenHeight * 0.04,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSetCounter() {
    final double screenHeight = MediaQuery.of(context).size.height;
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
              fontSize: isCurrent ? screenHeight * 0.030 : screenHeight * 0.025,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildControlButtons() {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: _undoPhase,
          icon: Icon(
            Icons.skip_previous_rounded,
            size: screenHeight * 0.035,
          ),
        ),
        IconButton(
          onPressed: _playPauseTimer,
          icon: Icon(
            _isPlay ? Icons.pause : Icons.play_arrow_rounded,
            size: screenHeight * 0.070,
          ),
        ),
        IconButton(
          onPressed: _skipPhase,
          icon: Icon(
            Icons.skip_next_rounded,
            size: screenHeight * 0.035,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsAndResetButtons(SettingsProvider settingsProvider) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: _showResetConfirmationDialog,
          icon: Icon(
            Icons.refresh_rounded,
            size: screenHeight * 0.025,
          ),
        ),
        IconButton(
          onPressed: settingsProvider.toggleSettingsCard,
          icon: Icon(
            Icons.settings,
            size: screenHeight * 0.025,
          ),
        ),
      ],
    );
  }

  void _showResetConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('Pomodoro sayacını sıfırlayalım mı?',
            style: kCalendarMonthYearTextStyle(context)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close)),
          const SizedBox(width: 12),
          IconButton(
              onPressed: () {
                _resetTimer(true);
                Navigator.of(context).pop();
                soundEffectProvider.playSound('minimalPop4');
              },
              icon: const Icon(Icons.check)),
        ],
      ),
    );
  }
}
