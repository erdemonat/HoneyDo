import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/components/banner.dart';
import 'package:honeydo/providers/settings_provider.model.dart';
import 'package:honeydo/screens/calender_card.dart';
import 'package:honeydo/screens/motivation_card.dart';
import 'package:honeydo/screens/pomodoro_card.dart';
import 'package:honeydo/constants/window_buttons.dart';
import 'package:honeydo/screens/settings_card.dart';
import 'package:honeydo/screens/todo_tasks_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          WindowTitleBarBox(
            child: MoveWindow(
              child: Row(
                children: [
                  const HoneydoBanner(),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        const WindowButtons(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Flexible(
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      height: 160,
                                      width: double.infinity,
                                      child: const MotivationCard(),
                                    ),
                                    const Expanded(
                                      child: PomodoroCard(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (settingsProvider.showSettingCards)
                          const SettingsCard(),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Column(
                      children: [
                        Flexible(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  height: 160,
                                  width: double.infinity,
                                  child: const CalenderCard(),
                                ),
                                const Expanded(
                                  flex: 10,
                                  child: TasksCard(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
