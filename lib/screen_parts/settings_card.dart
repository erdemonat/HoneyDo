import 'package:flutter/material.dart';
import 'package:honeydo/components/pomodoro_components/pomodoro_settings.dart';
import 'package:honeydo/components/titled_container.dart';
import 'package:honeydo/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard({super.key});

  @override
  State<SettingsCard> createState() => SettingsCardState();
}

class SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitledContainer(
              titleText: 'Tema',
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: ToggleSwitch(
                      // animationduration widgetin flexible olma süresinide belirliyor.
                      animationDuration: 500,
                      minHeight: screenHeight * 0.060,
                      minWidth: screenHeight * 0.090,
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
                      iconSize: screenWidth * 0.016,
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
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleDarkMode();
                        print('switched to: $index');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          ColorThemeBox(
                              boxColor: Colors.red,
                              onTap: () {
                                themeProvider.switchThemeIndex(0);
                              }),
                          ColorThemeBox(
                              boxColor: Colors.purpleAccent,
                              onTap: () {
                                themeProvider.switchThemeIndex(1);
                              }),
                          ColorThemeBox(
                              boxColor: Colors.greenAccent,
                              onTap: () {
                                themeProvider.switchThemeIndex(2);
                              }),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          ColorThemeBox(
                              boxColor: Colors.yellow,
                              onTap: () {
                                themeProvider.switchThemeIndex(3);
                              }),
                          ColorThemeBox(
                              boxColor: Colors.orange,
                              onTap: () {
                                themeProvider.switchThemeIndex(4);
                              }),
                          ColorThemeBox(
                              boxColor: Colors.deepPurple,
                              onTap: () {
                                themeProvider.switchThemeIndex(5);
                              }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TitledContainer(
              titleText: 'Pomodoro',
              child: PomodoroSettings(
                userPomodoroDuration: 25,
                userShortBreakDuration: 5,
                userLongBreakDuration: 15,
                userSetCount: 4,
                onSettingsChanged: (pomodoro, shortBreak, longBreak, setCount,
                    autoShortBreak, autoPomodoro) {},
              ),
            ),
            // ToggleSwitch(
            //   isVertical: true,
            //   // animationduration widgetin flexible olma süresinide belirliyor.
            //   animationDuration: 200,
            //   minHeight: screenHeight * 0.045,
            //   minWidth: screenWidth * 0.045,
            //   initialLabelIndex: 0,
            //   cornerRadius: 12,
            //   activeFgColor: Theme.of(context).colorScheme.tertiary,
            //   inactiveBgColor: Theme.of(context).colorScheme.secondary,
            //   inactiveFgColor: Theme.of(context).colorScheme.surface,
            //   activeBgColors: [
            //     [
            //       Theme.of(context).colorScheme.onSurface,
            //       Theme.of(context).colorScheme.onPrimary
            //     ],
            //     [
            //       Theme.of(context).colorScheme.onSurface,
            //       Theme.of(context).colorScheme.onPrimary
            //     ]
            //   ],
            //   totalSwitches: 2,
            //   centerText: true,
            //   fontSize: screenWidth * 0.012,
            //   labels: const [
            //     'Tr',
            //     'En',
            //   ],
            //   animate: true,
            //   curve: Curves.linear,
            //   onToggle: (index) {
            //     print('switched to: $index');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class ColorThemeBox extends StatelessWidget {
  final Color boxColor;
  final void Function() onTap;
  const ColorThemeBox({
    super.key,
    required this.boxColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: boxColor,
          ),
          height: screenHeight * 0.05,
          width: screenHeight * 0.05,
        ),
      ),
    );
  }
}
