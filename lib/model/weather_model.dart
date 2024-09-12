import 'package:isar/isar.dart';

part 'weather_model.g.dart';

@Collection()
class WeatherData {
  Id id = 2;

  late String city;
  late String weatherStatus;
  late int temperature;
  late int wind;
  late int humidity;
  late int precipitation;
}
