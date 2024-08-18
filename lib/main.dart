import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:honeydo/model/task_model.dart';
import 'package:honeydo/screens/homescreen.dart';
import 'package:honeydo/theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

late Isar isar;

void main() async {
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [TaskDataSchema, TaskDateSchema, TaskSchema, SubTaskSchema],
    directory: dir.path,
  );
  WidgetsFlutterBinding.ensureInitialized();
  appWindow.size = const Size(1200, 675);
  initializeDateFormatting('tr_TR', null).then((_) => runApp(const MyApp()));
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
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
