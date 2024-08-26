import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/screen_parts/calender_card.dart';
import 'package:honeydo/screen_parts/motivation_card.dart';
import 'package:honeydo/screen_parts/pomodoro_card.dart';
import 'package:honeydo/components/window_buttons.dart';
import 'package:honeydo/screen_parts/todo_tasks_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          WindowTitleBarBox(
            child: MoveWindow(
              child: Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  const WindowButtons(),
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
                                    //margin: const EdgeInsets.all(5),
                                    //color: Colors.blue,
                                    height: 200,
                                    width: double.infinity,
                                    child: CalenderCard(),
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
