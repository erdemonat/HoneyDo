import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:honeydo/firebase_options.dart';
import 'package:honeydo/providers/audio_player_provider.dart';
import 'package:honeydo/providers/language_provider.dart';
import 'package:honeydo/service/isar_service.dart';
import 'package:honeydo/providers/focus_date_provider.dart';
import 'package:honeydo/providers/pomodoro_provider.dart';
import 'package:honeydo/providers/settings_provider.model.dart';
import 'package:honeydo/providers/tasks_meals_provider.dart';
import 'package:honeydo/providers/theme_provider.dart';
import 'package:honeydo/providers/weather_provider.dart';
import 'package:honeydo/screens/homescreen.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:windows_single_instance/windows_single_instance.dart';

late IsarService isarService;

Future main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowsSingleInstance.ensureSingleInstance(args, "",
      onSecondWindow: (args) {});
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
  runApp(riverpod.ProviderScope(
    child: provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(
          create: (BuildContext context) => FocusDateProvider(),
        ),
        provider.ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),
        provider.ChangeNotifierProvider(
          create: (_) => themeProvider,
        ),
        provider.ChangeNotifierProvider(
          create: (_) => PomodoroProvider(),
        ),
        provider.ChangeNotifierProvider(
          create: (_) => TasksMealsProvider(),
        ),
        provider.ChangeNotifierProvider(
          create: (_) => WeatherProvider(),
        ),
        provider.ChangeNotifierProvider(
          create: (_) => soundEffectProvider,
        ),
        provider.ChangeNotifierProvider(
          create: (_) => languageProvider,
        ),
        // ChangeNotifierProvider(
        //   create: (_) => SyncCardProvider(),
        // ),
      ],
      child: const MyApp(),
    ),
  ));
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
      locale: AppLocalizations.supportedLocales[
          provider.Provider.of<LanguageProvider>(context).languageIndex],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: provider.Provider.of<ThemeProvider>(context).getThemeData,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
