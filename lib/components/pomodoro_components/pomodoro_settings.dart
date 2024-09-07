import 'package:flutter/material.dart';
import 'package:honeydo/components/constants.dart';
import 'package:honeydo/components/pomodoro_components/digit_text_field.dart';
import 'package:honeydo/providers/settings_provider.model.dart';
import 'package:provider/provider.dart';

class PomodoroSettings extends StatefulWidget {
  final int userPomodoroDuration;
  final int userShortBreakDuration;
  final int userLongBreakDuration;
  final int userSetCount;

  final Function(int pomodoro, int shortBreak, int longBreak, int setCount,
      bool autoShortBreak, bool autoPomodoro) onSettingsChanged;
  const PomodoroSettings({
    super.key,
    required this.userPomodoroDuration,
    required this.userShortBreakDuration,
    required this.userLongBreakDuration,
    required this.userSetCount,
    required this.onSettingsChanged,
  });

  @override
  State<PomodoroSettings> createState() => _PomodoroSettingsState();
}

class _PomodoroSettingsState extends State<PomodoroSettings> {
  late int pomodoroDuration;
  late int shortBreakDuration;
  late int longBreakDuration;
  late int setCount;
  bool isAutoShortBreak = true;
  bool isAutoPomodoro = true;

  @override
  void initState() {
    super.initState();
    pomodoroDuration = widget.userPomodoroDuration;
    shortBreakDuration = widget.userShortBreakDuration;
    longBreakDuration = widget.userLongBreakDuration;
    setCount = widget.userSetCount;
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              DigitTextField(
                labelText: "Pomodoro",
                userInput: pomodoroDuration,
                onChanged: (String value) {
                  pomodoroDuration = int.tryParse(value) ?? pomodoroDuration;
                },
              ),
              DigitTextField(
                labelText: "Set",
                userInput: setCount,
                onChanged: (value) {
                  setCount = int.tryParse(value) ?? setCount;
                },
              ),
            ],
          ),
          Row(
            children: [
              DigitTextField(
                labelText: "Kısa Mola",
                userInput: shortBreakDuration,
                onChanged: (String value) {
                  shortBreakDuration =
                      int.tryParse(value) ?? shortBreakDuration;
                },
              ),
              DigitTextField(
                labelText: "Uzun Mola",
                userInput: longBreakDuration,
                onChanged: (String value) {
                  longBreakDuration = int.tryParse(value) ?? longBreakDuration;
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: Text(
              'Oto. Mola',
              style: pomodoroSettingsTextStyle(context),
            ),
            value: isAutoShortBreak,
            onChanged: (bool value) {
              setState(() {
                isAutoShortBreak = !isAutoShortBreak;
              });
            },
          ),
          SwitchListTile(
            title: Text(
              'Oto. Pomodoro',
              style: pomodoroSettingsTextStyle(context),
            ),
            value: isAutoPomodoro,
            onChanged: (bool value) {
              setState(() {
                isAutoPomodoro = !isAutoPomodoro;
                print(isAutoPomodoro.toString());
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  settingsProvider.toggleSettingsCard();
                },
                icon: const Icon(Icons.close),
              ),
              IconButton(
                onPressed: () {
                  widget.onSettingsChanged(
                    pomodoroDuration,
                    shortBreakDuration,
                    longBreakDuration,
                    setCount,
                    isAutoShortBreak,
                    isAutoPomodoro,
                  );
                  settingsProvider.toggleSettingsCard();
                },
                icon: const Icon(Icons.check),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
