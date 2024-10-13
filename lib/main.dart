import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:honeydo/firebase_options.dart';
import 'package:honeydo/providers/audio_player_provider.dart';
import 'package:honeydo/providers/language_provider.dart';
import 'package:honeydo/providers/sync_card_provider.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

late IsarService isarService;

Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  isarService = IsarService();
  await isarService.db;
  await isarService.restoreWindowSizeAndPosition();
  ThemeProvider themeProvider = ThemeProvider();
  await themeProvider.loadTheme();
  SoundEffectProvider soundEffectProvider = SoundEffectProvider();
  await soundEffectProvider.loadVolumeData();
  LanguageProvider languageProvider = LanguageProvider();
  await languageProvider.loadLanguage();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => FocusDateProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => SettingsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => themeProvider,
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
        create: (_) => soundEffectProvider,
      ),
      ChangeNotifierProvider(
        create: (_) => languageProvider,
      ),
      ChangeNotifierProvider(
        create: (_) => SyncCardProvider(),
      ),
    ],
    child: const MyApp(),
  ));
  appWindow.show();
  doWhenWindowReady(() {
    final win = appWindow;
    win.minSize = const Size(1200, 820);
    win.maxSize = const Size(2560, 1440);
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
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: AppLocalizations.supportedLocales[Provider.of<LanguageProvider>(context).languageIndex],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: Provider.of<ThemeProvider>(context).getThemeData,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
