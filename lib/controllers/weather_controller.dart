import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../environment/env_config.dart';
import '../model/weather_data.dart';


class WeatherController extends GetxController{

  var isLoading = false.obs;
  var hasError = false.obs;
  var weatherData = Rxn<WeatherData>();

  Future<void> getWeather(String lat, String lon) async {
    isLoading(true);
    hasError(false);

    try {
      final response = await http.get(Uri.parse(
          "${EnvConfig.baseUrl}/weather?lat=$lat&lon=$lon&appid=${EnvConfig.apiKey}&units=metric"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        weatherData.value = WeatherData.fromJson(data);
      } else {
        hasError(true);
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      hasError(true);
      rethrow;
    } finally {
      isLoading(false);
    }
  }


  Future<void> getWeatherByCityName(String cityName) async {
    isLoading(true);
    hasError(false);

    try {
      final response = await http.get(Uri.parse(
          '${EnvConfig.baseUrl}/weather?q=$cityName&appid=${EnvConfig.apiKey}&units=metric'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        weatherData.value = WeatherData.fromJson(data);
      } else {
        hasError(true);
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      hasError(true);
      rethrow;
    } finally {
      isLoading(false);
    }
  }


  @override
  void onInit() {
    super.onInit();
  }

}