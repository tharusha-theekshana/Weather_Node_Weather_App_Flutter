import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../environment/env_config.dart';
import '../model/weather_data.dart';


class WeatherController extends GetxController{

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

  @override
  void onInit() {
    super.onInit();
  }

}