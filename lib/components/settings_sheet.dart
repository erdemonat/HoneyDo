import 'package:flutter/material.dart';
import 'package:honeydo/components/digit_text_field.dart';

class SettingsSheet extends StatefulWidget {
  final int userPomodoroDuration;
  final int userShortBreakDuration;
  final int userLongBreakDuration;
  final int userSetCount;
  final Function(int pomodoro, int shortBreak, int longBreak, int setCount,
      bool autoShortBreak, bool autoPomodoro) onSettingsChanged;
  const SettingsSheet(
      {super.key,
      required this.userPomodoroDuration,
      required this.userShortBreakDuration,
      required this.userLongBreakDuration,
      required this.userSetCount,
      required this.onSettingsChanged});

  @override
  State<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet> {
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
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('İptal Et'),
              ),
              TextButton(
                onPressed: () {
                  widget.onSettingsChanged(
                    pomodoroDuration,
                    shortBreakDuration,
                    longBreakDuration,
                    setCount,
                    isAutoShortBreak,
                    isAutoPomodoro,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Tamamla'),
              ),
            ],
          ),
          const SizedBox(height: 16),
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
            title: const Text('Molaları doğrudan başlat'),
            value: isAutoShortBreak,
            onChanged: (bool value) {
              setState(() {
                isAutoShortBreak = !isAutoShortBreak;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Pomodoro doğrudan başlat'),
            value: isAutoPomodoro,
            onChanged: (bool value) {
              setState(() {
                isAutoPomodoro = !isAutoPomodoro;
                print(isAutoPomodoro.toString());
              });
            },
          ),
        ],
      ),
    );
  }
}
