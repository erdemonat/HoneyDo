import 'package:flutter/material.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/components/pomodoro_components/digit_text_field.dart';
import 'package:honeydo/providers/audio_player_provider.dart';
import 'package:honeydo/providers/settings_provider.model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PomodoroSettings extends StatefulWidget {
  final int userPomodoroDuration;
  final int userShortBreakDuration;
  final int userLongBreakDuration;
  final int userSetCount;
  final bool autoBreak;
  final bool autoPomodoro;

  final Function(int pomodoro, int shortBreak, int longBreak, int setCount, bool autoBreak, bool autoPomodoro) onSettingsChanged;
  const PomodoroSettings({
    super.key,
    required this.userPomodoroDuration,
    required this.userShortBreakDuration,
    required this.userLongBreakDuration,
    required this.userSetCount,
    required this.onSettingsChanged,
    required this.autoBreak,
    required this.autoPomodoro,
  });

  @override
  State<PomodoroSettings> createState() => _PomodoroSettingsState();
}

class _PomodoroSettingsState extends State<PomodoroSettings> {
  late int pomodoroDuration;
  late int shortBreakDuration;
  late int longBreakDuration;
  late int setCount;
  late bool autoBreak;
  late bool autoPomodoro;

  @override
  void initState() {
    super.initState();
    pomodoroDuration = widget.userPomodoroDuration;
    shortBreakDuration = widget.userShortBreakDuration;
    longBreakDuration = widget.userLongBreakDuration;
    setCount = widget.userSetCount;
    autoBreak = widget.autoBreak;
    autoPomodoro = widget.autoPomodoro;
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final playerProvider = Provider.of<SoundEffectProvider>(context, listen: false);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              DigitTextField(
                labelText: appLocalizations.pomodoro,
                userInput: pomodoroDuration,
                onChanged: (String value) {
                  pomodoroDuration = int.tryParse(value) ?? pomodoroDuration;
                },
                maxValue: 254,
              ),
              DigitTextField(
                labelText: appLocalizations.set,
                userInput: setCount,
                onChanged: (value) {
                  setCount = int.tryParse(value) ?? setCount;
                },
                maxValue: 10,
              ),
            ],
          ),
          Row(
            children: [
              DigitTextField(
                labelText: appLocalizations.shortBreak,
                userInput: shortBreakDuration,
                onChanged: (String value) {
                  shortBreakDuration = int.tryParse(value) ?? shortBreakDuration;
                },
                maxValue: 254,
              ),
              DigitTextField(
                labelText: appLocalizations.longBreak,
                userInput: longBreakDuration,
                onChanged: (String value) {
                  longBreakDuration = int.tryParse(value) ?? longBreakDuration;
                },
                maxValue: 254,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            activeColor: Theme.of(context).colorScheme.primary,
            activeTrackColor: Theme.of(context).colorScheme.tertiary,
            inactiveThumbColor: Theme.of(context).colorScheme.tertiary,
            inactiveTrackColor: Theme.of(context).colorScheme.surface,
            splashRadius: 0,
            trackOutlineColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.tertiary),
            title: Text(
              appLocalizations.autoBreak,
              style: kPomodoroSettingsTextStyle(context),
            ),
            value: autoBreak,
            onChanged: (bool value) {
              setState(() {
                autoBreak = !autoBreak;
              });
              playerProvider.playSound(value ? 'happyPop2' : 'happyPop1');
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).colorScheme.primary,
            activeTrackColor: Theme.of(context).colorScheme.tertiary,
            inactiveThumbColor: Theme.of(context).colorScheme.tertiary,
            inactiveTrackColor: Theme.of(context).colorScheme.surface,
            splashRadius: 0,
            trackOutlineColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.tertiary),
            title: Text(
              appLocalizations.autoPomodoro,
              style: kPomodoroSettingsTextStyle(context),
            ),
            value: autoPomodoro,
            onChanged: (bool value) {
              setState(() {
                autoPomodoro = !autoPomodoro;
              });
              playerProvider.playSound(value ? 'happyPop2' : 'happyPop1');
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
                  setState(() {
                    pomodoroDuration = 25;
                    shortBreakDuration = 5;
                    longBreakDuration = 15;
                    setCount = 4;
                    autoBreak = false;
                    autoPomodoro = false;
                  });
                },
                icon: const Icon(Icons.refresh_rounded),
              ),
              IconButton(
                onPressed: () {
                  widget.onSettingsChanged(
                    pomodoroDuration,
                    shortBreakDuration,
                    longBreakDuration,
                    setCount,
                    autoBreak,
                    autoPomodoro,
                  );
                  settingsProvider.toggleSettingsCard();
                  playerProvider.playSound('infoPop2');
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
