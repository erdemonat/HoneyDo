import 'package:flutter/material.dart';
import 'package:honeydo/components/dark_mode_switch.dart';
import 'package:honeydo/components/pomodoro_components/pomodoro_settings.dart';
import 'package:honeydo/components/titled_container.dart';
import 'package:honeydo/providers/pomodoro_provider.dart';
import 'package:honeydo/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard({super.key});

  @override
  State<SettingsCard> createState() => SettingsCardState();
}

class SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    final pomodoroProvider = Provider.of<PomodoroProvider>(context, listen: false);
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
              borderCutWidth: 50,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    SizedBox(
                      width: screenHeight * 0.18,
                      height: 40,
                      child: const DarkModeSwitch(),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            ColorThemeBox(
                                index: 0,
                                onTap: () {
                                  themeProvider.switchThemeIndex(0);
                                }),
                            ColorThemeBox(
                              index: 1,
                              onTap: () {
                                themeProvider.switchThemeIndex(1);
                              },
                            ),
                            ColorThemeBox(
                              index: 2,
                              onTap: () {
                                themeProvider.switchThemeIndex(2);
                              },
                            ),
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
                              index: 3,
                              onTap: () {
                                themeProvider.switchThemeIndex(3);
                              },
                            ),
                            ColorThemeBox(
                              index: 4,
                              onTap: () {
                                themeProvider.switchThemeIndex(4);
                              },
                            ),
                            ColorThemeBox(
                              index: 5,
                              onTap: () {
                                themeProvider.switchThemeIndex(5);
                              },
                            ),
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
                              index: 6,
                              onTap: () {
                                themeProvider.switchThemeIndex(6);
                              },
                            ),
                            ColorThemeBox(
                              index: 7,
                              onTap: () {
                                themeProvider.switchThemeIndex(7);
                              },
                            ),
                            ColorThemeBox(
                              index: 8,
                              onTap: () {
                                themeProvider.switchThemeIndex(8);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            TitledContainer(
              titleText: 'Pomodoro',
              borderCutWidth: 80,
              child: PomodoroSettings(
                userPomodoroDuration: pomodoroProvider.pomodoroDuration.inMinutes,
                userShortBreakDuration: pomodoroProvider.shortBreakDuration.inMinutes,
                userLongBreakDuration: pomodoroProvider.longBreakDuration.inMinutes,
                userSetCount: pomodoroProvider.setCount,
                autoBreak: pomodoroProvider.autoBreak,
                autoPomodoro: pomodoroProvider.autoPomodoro,
                onSettingsChanged: (pomodoro, shortBreak, longBreak, setCount, autoBreak, autoPomodoro) {
                  setState(() {
                    pomodoroProvider.setAllPomodoroSettings(Duration(minutes: pomodoro), Duration(minutes: shortBreak), Duration(minutes: longBreak), setCount, autoBreak, autoPomodoro);
                  });
                },
              ),
            ),
            TitledContainer(
                titleText: 'Hava Durumu',
                child: SizedBox(
                  width: double.maxFinite,
                  child: Text('Şehir: '),
                ),
                borderCutWidth: 100)
          ],
        ),
      ),
    );
  }
}

class ColorThemeBox extends StatelessWidget {
  final int index;
  final void Function() onTap;
  const ColorThemeBox({
    super.key,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    //final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface,
              width: 2,
            ),
            borderRadius: themeProvider.currentThemeIndex == index ? BorderRadius.circular(8) : BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
            ],
            gradient: LinearGradient(
              colors: [
                themeProvider.getThemePrimaryColor(index),
                themeProvider.getThemeTertiaryColor(index),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [
                0.5,
                0.5
              ],
            ),
          ),
          height: screenHeight * 0.05,
          width: screenHeight * 0.05,
        ),
      ),
    );
  }
}
