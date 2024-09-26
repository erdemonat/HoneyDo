import 'package:isar/isar.dart';

part 'window_model.g.dart';

@collection
class WindowSettings {
  Id id = 1;

  double x = 0;
  double y = 0;
  double width = 1200;
  double height = 780;

  WindowSettings({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });
}