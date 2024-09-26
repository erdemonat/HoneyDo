import 'package:isar/isar.dart';

part 'weather_model.g.dart';

@Collection()
class WeatherData {
  Id id = 2;

  late String city;
  late String formattedCity;
  late String weatherStatus;
  late String iconCode;
  late String temperature;
}
