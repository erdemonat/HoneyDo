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

@Collection()
class Language {
  Id id = 3;

  late int languageIndex;
}

@Collection()
class CloudMetaData {
  Id id = 4;

  String? lastDownloadTime;

  CloudMetaData({this.lastDownloadTime});

  void updateDownloadTime(String newDownloadTime) {
    lastDownloadTime = newDownloadTime;
  }
}
