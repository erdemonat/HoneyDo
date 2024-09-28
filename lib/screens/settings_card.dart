import 'package:flutter/material.dart';
import 'package:honeydo/components/dark_mode_switch.dart';
import 'package:honeydo/components/editable_textfield.dart';
import 'package:honeydo/components/pomodoro_components/pomodoro_settings.dart';
import 'package:honeydo/components/sound_slider.dart';
import 'package:honeydo/components/titled_container.dart';
import 'package:honeydo/model/editable_textfield_model.dart';
import 'package:honeydo/providers/pomodoro_provider.dart';
import 'package:honeydo/providers/theme_provider.dart';
import 'package:honeydo/providers/weather_provider.dart';
import 'package:provider/provider.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard({super.key});

  @override
  State<SettingsCard> createState() => SettingsCardState();
}

class SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    final pomodoroProvider =
        Provider.of<PomodoroProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    return Container(
      width: double.infinity,
      height: double.maxFinite,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          scrollbarTheme: const ScrollbarThemeData(
            thumbVisibility: WidgetStatePropertyAll(false),
            trackVisibility: WidgetStatePropertyAll(false),
            thumbColor: WidgetStatePropertyAll(Colors.transparent),
            trackColor: WidgetStatePropertyAll(Colors.transparent),
            trackBorderColor: WidgetStatePropertyAll(Colors.transparent),
          ),
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
                      const SizedBox(
                        width: 140,
                        height: 40,
                        child: DarkModeSwitch(),
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
              const TitledContainer(
                titleText: 'Ses Düzeyi',
                borderCutWidth: 85,
                child: SizedBox(
                  height: 90,
                  child: SoundSlider(),
                ),
              ),
              TitledContainer(
                titleText: 'Hava Durumu',
                borderCutWidth: 100,
                child: SizedBox(
                  width: double.maxFinite,
                  child: Wrap(
                    children: [
                      EditableTextField(
                        hintText: '',
                        maxLength: 100,
                        model: ListModel(
                            title: 'Şehir',
                            subTitle: weatherProvider.formattedCity),
                      )
                    ],
                  ),
                ),
              ),
              TitledContainer(
                titleText: 'Pomodoro',
                borderCutWidth: 80,
                child: PomodoroSettings(
                  userPomodoroDuration:
                      pomodoroProvider.pomodoroDuration.inMinutes,
                  userShortBreakDuration:
                      pomodoroProvider.shortBreakDuration.inMinutes,
                  userLongBreakDuration:
                      pomodoroProvider.longBreakDuration.inMinutes,
                  userSetCount: pomodoroProvider.setCount,
                  autoBreak: pomodoroProvider.autoBreak,
                  autoPomodoro: pomodoroProvider.autoPomodoro,
                  onSettingsChanged: (pomodoro, shortBreak, longBreak, setCount,
                      autoBreak, autoPomodoro) {
                    setState(() {
                      pomodoroProvider.setAllPomodoroSettings(
                          Duration(minutes: pomodoro),
                          Duration(minutes: shortBreak),
                          Duration(minutes: longBreak),
                          setCount,
                          autoBreak,
                          autoPomodoro);
                    });
                  },
                ),
              ),
            ],
          ),
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
            borderRadius: themeProvider.currentThemeIndex == index
                ? BorderRadius.circular(8)
                : BorderRadius.circular(32),
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
              stops: const [0.5, 0.5],
            ),
          ),
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
