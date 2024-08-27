import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:honeydo/model/focus_date_model.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:honeydo/screens/homescreen.dart';
import 'package:honeydo/theme.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

late Isar isar;
final FlutterLocalization localization = FlutterLocalization.instance;

void main() async {
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [HoneyDoDataSchema, DateLinksSchema, TaskSchema, SubTaskSchema, MealSchema],
    directory: dir.path,
  );
  WidgetsFlutterBinding.ensureInitialized();
  appWindow.size = const Size(1200, 675);
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => FocusDateModel(),
    child: const MyApp(),
  ));
  appWindow.show();
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1200, 675);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "HoneyDo";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: localization.localizationsDelegates,
      locale: const Locale('tr', 'TR'),
      supportedLocales: const [Locale('tr')],
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
