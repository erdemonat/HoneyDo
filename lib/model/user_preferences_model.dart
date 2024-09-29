import 'package:isar/isar.dart';

part 'user_preferences_model.g.dart';

@Collection()
class VolumeData {
  Id id = 1;

  late double currentVolume;
}

@Collection()
class ThemeData {
  Id id = 2;

  late bool isDarkMode;
  late int currentThemeIndex;
}
