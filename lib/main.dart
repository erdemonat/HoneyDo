import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:honeydo/providers/audio_player_provider.dart';
import 'package:honeydo/service/isar_service.dart';
import 'package:honeydo/providers/focus_date_provider.dart';
import 'package:honeydo/providers/pomodoro_provider.dart';
import 'package:honeydo/providers/settings_provider.model.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
import 'package:honeydo/providers/theme_provider.dart';
import 'package:honeydo/providers/weather_provider.dart';
import 'package:honeydo/screens/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

late IsarService isarService;

Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  isarService = IsarService();
  await isarService.db;
  await isarService.restoreWindowSizeAndPosition();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => FocusDateProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => SettingsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => PomodoroProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => TasksMealsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => WeatherProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => SoundEffectProvider(),
      ),
    ],
    child: const MyApp(),
  ));
  appWindow.show();
  doWhenWindowReady(() {
    final win = appWindow;
    win.minSize = const Size(1200, 780);
    win.title = "HoneyDo";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('tr', 'TR'),
      supportedLocales: const [Locale('tr', 'TR')],
      theme: Provider.of<ThemeProvider>(context).getThemeData,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
