import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
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
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.donut_small_sharp,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Center(child: Text('HoneyDo')),
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
                      //fit: StackFit.expand,
                      children: [
                        Column(
                          children: [
                            Flexible(
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        //margin: const EdgeInsets.all(5),
                                        height: 200,
                                        width: double.infinity,
                                        child: const MotivationCard(),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: Container(
                                        //margin: const EdgeInsets.all(5),
                                        child: const PomodoroCard(),
                                      ),
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
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    //color: Colors.blue,
                                    //height: 200,
                                    width: double.infinity,
                                    child: const CalenderCard(),
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                    //margin: const EdgeInsets.all(5),

                                    child: const TasksCard(),
                                  ),
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
