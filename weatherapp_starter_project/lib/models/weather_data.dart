import 'package:flutter/cupertino.dart';
import 'package:weatherapp_starter_project/models/weather_data_current.dart';
import 'package:weatherapp_starter_project/models/weather_data_daily.dart';
import 'package:weatherapp_starter_project/models/weather_data_hoult.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;

  WeatherData([this.current, this.hourly, this.daily]);
// function to fetch these values
  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
  WeatherDataDaily getDailyWeather() => daily!;
}
