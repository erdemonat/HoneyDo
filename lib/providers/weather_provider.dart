import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/weather_model.dart';
import 'package:honeydo/service/networking.dart';

class WeatherProvider with ChangeNotifier {
  static const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
  static String get apiKey => dotenv.env['OPENWEATHER_API_KEY']!;

  String _city = "ankara";
  String _formattedCity = "Ankara";
  String _weatherStatus = "";
  int _temperature = 30;
  String _iconCode = "";
  final List<String> weatherTitle = [];

  String get city => _city;
  String get formattedCity => _formattedCity;
  String get weatherStatus => _weatherStatus;
  String get iconCode => _iconCode;
  int get temperature => _temperature;

  void updateTemperature(double weatherDataTemperature) {
    _temperature = weatherDataTemperature.toInt();
  }

  void changeCity(String selectedCity) {
    _city = selectedCity;
    _formattedCity = selectedCity.replaceAll('%20', ' ');
    _formattedCity = _formattedCity.split(' ').map((word) {
      return word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : '';
    }).join(' ');
  }

  Future<void> loadSavedCity() async {
    _city = await isarService.getSavedCity();
    _formattedCity = await isarService.getSavedFormattedCity();
    notifyListeners();
  }

  void updateWeatherStatus(String weatherDataStatus) {
    _weatherStatus = weatherDataStatus;
  }

  void updateWeatherIcon(String weatherDataIcon) {
    _iconCode = weatherDataIcon;
  }

  Future<void> updateWeatherData() async {
    NetworkHelper networkHelper = NetworkHelper(
      url: '$openWeatherMapURL?q=$_city&appid=$apiKey&lang=tr&units=metric',
    );

    var weatherData = await networkHelper.getData();
    double temperature = weatherData['main']['temp'];
    String status = weatherData['weather'][0]['description'];
    status = status.split(' ').map((word) {
      return word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : '';
    }).join(' ');
    String icon = weatherData['weather'][0]['icon'];
    updateTemperature(temperature);
    updateWeatherStatus(status);
    updateWeatherIcon(icon);

    weatherTitle.clear();
    weatherTitle.add(status);
    weatherTitle.add('${temperature.round().toString()} C° $formattedCity');

    WeatherData weatherDataToSave = WeatherData()
      ..city = _city
      ..formattedCity = _formattedCity
      ..weatherStatus = status
      ..iconCode = icon
      ..temperature = temperature;

    await isarService.saveWeatherData(weatherDataToSave);
    notifyListeners();
  }

  IconData getWeatherIcon(String iconCode) {
    switch (iconCode) {
      case '01d':
      case '01n':
        return Icons.wb_sunny; // Clear sky
      case '02d':
      case '02n':
        return Icons.cloud; // Few clouds
      case '03d':
      case '03n':
        return Icons.cloud; // Scattered clouds
      case '04d':
      case '04n':
        return Icons.cloud; // Broken clouds
      case '09d':
      case '09n':
        return Icons.grain; // Shower rain
      case '10d':
      case '10n':
        return Icons.beach_access; // Rain
      case '11d':
      case '11n':
        return Icons.flash_on; // Thunderstorm
      case '13d':
      case '13n':
        return Icons.ac_unit; // Snow
      case '50d':
      case '50n':
        return Icons.filter_drama; // Mist
      default:
        return Icons.settings_backup_restore; // Unknown weather condition
    }
  }
}
