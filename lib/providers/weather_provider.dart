import 'package:flutter/material.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/weather_model.dart';
import 'package:honeydo/service/isar_service.dart';
import 'package:honeydo/service/networking.dart';

class WeatherProvider with ChangeNotifier {
  final IsarService _isarService = IsarService();
  static const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
  static const apiKey = '5e1995d1e2e7a41bbfe0bbb7e662625a';

  String _city = "ankara";
  String _weatherStatus = "";
  int _temperature = 30;
  final List<String> weatherTitle = [];

  String get city => _city;
  String get weatherStatus => _weatherStatus;
  int get temperature => _temperature;

  void updateTemperature(double weatherDataTemperature) {
    _temperature = weatherDataTemperature.toInt();
  }

  void changeCity(String selectedCity) {
    _city = selectedCity;
    print(_city);
  }

  Future<void> loadSavedCity() async {
    _city = await isarService.getSavedCity();
    notifyListeners();
  }

  void updateWeatherStatus(String weatherDataStatus) {
    _weatherStatus = weatherDataStatus;
  }

  Future<void> updateWeatherData() async {
    NetworkHelper networkHelper = NetworkHelper(
      url: '$openWeatherMapURL?q=$_city&appid=$apiKey&lang=tr&units=metric',
    );

    var weatherData = await networkHelper.getData();
    double temperature = weatherData['main']['temp'];
    String status = weatherData['weather'][0]['description'];
    updateTemperature(temperature);
    updateWeatherStatus(status);

    weatherTitle.clear();
    weatherTitle.add('${temperature.round().toString()} C°');
    weatherTitle.add(status[0].toUpperCase() + status.substring(1).toLowerCase());
    weatherTitle.add(_city[0].toUpperCase() + _city.substring(1).toLowerCase());

    WeatherData weatherDataToSave = WeatherData()
      ..city = _city
      ..weatherStatus = status
      ..temperature = temperature;

    await isarService.saveWeatherData(weatherDataToSave);
    notifyListeners();
  }
}
