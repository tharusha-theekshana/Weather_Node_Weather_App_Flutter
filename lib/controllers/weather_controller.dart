import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../environment/env_config.dart';
import '../model/weather_data.dart';


class WeatherController extends GetxController{

  late Future<WeatherData> weatherData;
  bool isLoading = false;
  bool hasError = false;

  Future<WeatherData> getWeather(String lat, String lon) async {
    final response = await http.get(Uri.parse(
        "${EnvConfig.baseUrl}/weather?lat=$lat&lon=$lon&appid=${EnvConfig.apiKey}&units=metric"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return WeatherData.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<WeatherData> getWeatherByCityName(String cityName) async {
    final response = await http.get(Uri.parse(
        '${EnvConfig.baseUrl}/weather?q=$cityName&appid=${EnvConfig.apiKey}&units=metric'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return WeatherData.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

}