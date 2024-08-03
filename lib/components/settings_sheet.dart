import 'package:flutter/material.dart';
import 'package:honeydo/components/digit_text_field.dart';

class SettingsSheet extends StatefulWidget {
  @override
  State<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet> {
  @override
  Widget build(BuildContext context) {
    bool isAutoShortBreak = false;
    bool isAutoPomodoro = false;
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: () {}, child: const Text('İptal Et')),
              TextButton(onPressed: () {}, child: const Text('Tamamla')),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DigitTextField(labelText: "Pomodoro"),
              DigitTextField(labelText: "Set"),
            ],
          ),
          Row(
            children: [
              DigitTextField(labelText: "Kısa Mola"),
              DigitTextField(labelText: "Uzun Mola"),
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
