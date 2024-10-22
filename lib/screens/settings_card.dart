import 'package:flutter/material.dart';
import 'package:honeydo/components/dark_mode_switch.dart';
import 'package:honeydo/components/editable_textfield.dart';
import 'package:honeydo/components/flag_box.dart';
import 'package:honeydo/components/pomodoro_components/pomodoro_settings.dart';
import 'package:honeydo/components/sound_slider.dart';
import 'package:honeydo/components/titled_container.dart';
import 'package:honeydo/constants/constants.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/editable_textfield_model.dart';
import 'package:honeydo/providers/pomodoro_provider.dart';
import 'package:honeydo/providers/theme_provider.dart';
import 'package:honeydo/providers/weather_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard({super.key});

  @override
  State<SettingsCard> createState() => SettingsCardState();
}

class SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    final pomodoroProvider = Provider.of<PomodoroProvider>(context, listen: false);
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
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
                titleText: appLocalizations.theme,
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 140,
                        height: 40,
                        child: DarkModeSwitch(),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              ColorThemeBox(index: 0),
                              ColorThemeBox(index: 1),
                              ColorThemeBox(index: 2),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              ColorThemeBox(index: 3),
                              ColorThemeBox(index: 4),
                              ColorThemeBox(index: 5),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              ColorThemeBox(index: 6),
                              ColorThemeBox(index: 7),
                              ColorThemeBox(index: 8),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              TitledContainer(
                titleText: appLocalizations.voiceVolume,
                child: const SizedBox(
                  height: 90,
                  child: SoundSlider(),
                ),
              ),
              TitledContainer(
                titleText: appLocalizations.pomodoro,
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
                titleText: appLocalizations.weather,
                child: SizedBox(
                  width: double.maxFinite,
                  child: Wrap(
                    children: [
                      EditableTextField(
                        key: ValueKey(appLocalizations.city),
                        hintText: '',
                        maxLength: 100,
                        model: ListModel(
                          title: appLocalizations.city,
                          subTitle: weatherProvider.formattedCity,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              TitledContainer(
                titleText: appLocalizations.language,
                child: Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            FlagBox(index: 7),
                            FlagBox(index: 1),
                            FlagBox(index: 0),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            FlagBox(index: 4),
                            FlagBox(index: 2),
                            FlagBox(index: 6),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            FlagBox(index: 3),
                            FlagBox(index: 5),
                            FlagBox(index: 8),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          appLocalizations.resetAllData,
                          style: kCalendarMonthYearTextStyle(context).copyWith(fontSize: 18),
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        IconButton(
                          onPressed: () async {
                            isarService.clearIsarDatabase();
                          },
                          icon: const Icon(Icons.check),
                        ),
                      ],
                    ),
                  ),
                  style: TextButton.styleFrom(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    appLocalizations.resetData,
                    style: kCardSubTitleTextStyle(context),
                  ),
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
  const ColorThemeBox({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          themeProvider.switchThemeIndex(index);
          isarService.saveThemeData(index, themeProvider.isDarkMode);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface,
              width: 2,
            ),
            borderRadius: themeProvider.currentThemeIndex == index ? BorderRadius.circular(8) : BorderRadius.circular(32),
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
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
