import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/weather_model.dart';
import 'package:honeydo/service/networking.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WeatherProvider with ChangeNotifier {
  static const openWeatherMapURL =
      'https://api.openweathermap.org/data/2.5/weather';
  static String get apiKey => dotenv.env['OPENWEATHER_API_KEY']!;

  Timer? _weatherUpdateTimer;

  String _city = "ankara";
  String _formattedCity = "Ankara";
  String _weatherStatus = "";
  String _temperature = "30";
  String _iconCode = "";
  final List<String> weatherTitle = [];

  String get city => _city;
  String get formattedCity => _formattedCity;
  String get weatherStatus => _weatherStatus;
  String get iconCode => _iconCode;
  String get temperature => _temperature;

  void updateTemperature(String weatherDataTemperature) {
    _temperature = weatherDataTemperature;
  }

  void changeCity(String selectedCity) {
    _city = selectedCity;
    _formattedCity = selectedCity.replaceAll('%20', ' ');
    _formattedCity = _formattedCity.split(' ').map((word) {
      return word.isNotEmpty
          ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
          : '';
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

  Future<void> updateWeatherData({bool repeat = false}) async {
    NetworkHelper networkHelper = NetworkHelper(
      url: '$openWeatherMapURL?q=$_city&appid=$apiKey&lang=tr&units=metric',
    );

    var weatherData = await networkHelper.getData();
    double temperature = (weatherData['main']['temp'] as num).toDouble();
    String status = weatherData['weather'][0]['description'];
    status = status.split(' ').map((word) {
      return word.isNotEmpty
          ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
          : '';
    }).join(' ');
    String icon = weatherData['weather'][0]['icon'];
    updateTemperature(temperature.toString());
    updateWeatherStatus(status);
    updateWeatherIcon(icon);

    weatherTitle.clear();
    weatherTitle.add(status);
    weatherTitle
        .add('${_temperature.toString().split('.')[0]} C° $formattedCity');

    WeatherData weatherDataToSave = WeatherData()
      ..city = _city
      ..formattedCity = _formattedCity
      ..weatherStatus = status
      ..iconCode = icon
      ..temperature = temperature.toString();

    await isarService.saveWeatherData(weatherDataToSave);
    notifyListeners();

    if (repeat) {
      _weatherUpdateTimer?.cancel();
      _weatherUpdateTimer =
          Timer.periodic(const Duration(hours: 2), (Timer timer) {
        updateWeatherData(repeat: true);
      });
    }
  }

  Widget getWeatherIcon(BuildContext context, String iconCode) {
    // Clear sky
    switch (iconCode) {
      case '01d':
      case '01n':
        return Icon(
          Icons.wb_sunny,
          size: 18,
          color: Theme.of(context).colorScheme.onSurface,
        );
      // Few clouds
      case '02d':
      case '02n':
        return Icon(
          Icons.cloud,
          size: 18,
          color: Theme.of(context).colorScheme.onSurface,
        );
      // Scattered clouds
      case '03d':
      case '03n':
        return Icon(
          Icons.cloud,
          size: 18,
          color: Theme.of(context).colorScheme.onSurface,
        );
      // Broken clouds
      case '04d':
      case '04n':
        return Icon(
          Icons.cloud,
          size: 18,
          color: Theme.of(context).colorScheme.onSurface,
        );
      // Shower rain
      case '09d':
      case '09n':
        return Icon(
          Icons.grain,
          size: 18,
          color: Theme.of(context).colorScheme.onSurface,
        );
      // Rain
      case '10d':
      case '10n':
        return Icon(
          Icons.beach_access,
          size: 18,
          color: Theme.of(context).colorScheme.onSurface,
        );
      // Thunderstorm
      case '11d':
      case '11n':
        return Icon(
          Icons.flash_on,
          size: 18,
          color: Theme.of(context).colorScheme.onSurface,
        );
      // Snow
      case '13d':
      case '13n':
        return Icon(
          Icons.ac_unit,
          size: 18,
          color: Theme.of(context).colorScheme.onSurface,
        );
      // Mist
      case '50d':
      case '50n':
        return Icon(
          Icons.filter_drama,
          size: 18,
          color: Theme.of(context).colorScheme.onSurface,
        );
      // Unknown weather condition
      default:
        return SizedBox(
          width: 15,
          height: 15,
          child: LoadingAnimationWidget.waveDots(
            color: Theme.of(context).colorScheme.onSurface,
            size: 20,
          ),
        );
    }
  }
}
