import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard({super.key});

  @override
  State<SettingsCard> createState() => SettingsCardState();
}

class SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: double.maxFinite,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ToggleSwitch(
                // animationduration widgetin flexible olma süresinide belirliyor.
                animationDuration: 500,
                minHeight: screenHeight * 0.045,
                minWidth: screenWidth * 0.045,
                initialLabelIndex: 0,
                cornerRadius: 12,
                activeFgColor: Theme.of(context).colorScheme.tertiary,
                inactiveBgColor: Theme.of(context).colorScheme.secondary,
                inactiveFgColor: Theme.of(context).colorScheme.surface,
                activeBgColors: [
                  [
                    Theme.of(context).colorScheme.onSurface,
                    Theme.of(context).colorScheme.onPrimary
                  ],
                  [
                    Theme.of(context).colorScheme.onSurface,
                    Theme.of(context).colorScheme.onPrimary
                  ]
                ],
                totalSwitches: 2,
                centerText: true,
                fontSize: screenWidth * 0.012,
                labels: const [
                  'Tr',
                  'En',
                ],
                animate: true,
                curve: Curves.linear,
                onToggle: (index) {
                  print('switched to: $index');
                },
              ),
              ToggleSwitch(
                // animationduration widgetin flexible olma süresinide belirliyor.
                animationDuration: 500,
                minHeight: screenHeight * 0.045,
                minWidth: screenWidth * 0.045,
                initialLabelIndex: 0,
                cornerRadius: 12,
                activeFgColor: Theme.of(context).colorScheme.tertiary,
                inactiveBgColor: Theme.of(context).colorScheme.secondary,
                inactiveFgColor: Theme.of(context).colorScheme.surface,
                totalSwitches: 2,
                icons: const [
                  Icons.nights_stay,
                  Icons.sunny,
                ],
                iconSize: screenWidth * 0.012,
                activeBgColors: [
                  [
                    Theme.of(context).colorScheme.onSurface,
                    Theme.of(context).colorScheme.onPrimary
                  ],
                  [
                    Theme.of(context).colorScheme.onSurface,
                    Theme.of(context).colorScheme.onPrimary
                  ]
                ],
                animate: true,
                curve: Curves.bounceInOut,
                onToggle: (index) {
                  print('switched to: $index');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
