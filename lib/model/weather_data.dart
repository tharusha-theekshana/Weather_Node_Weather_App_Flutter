import 'package:intl/intl.dart';

class WeatherData {
  String cityName;
  String longitude;
  String latitude;
  String mainWeather;
  String description;
  String temperature;
  String tempMax;
  String tempMin;
  String sunrise;
  String sunset;
  String humidity;
  String visibility;
  String windSpeed;

  WeatherData(
      {required this.cityName,
        required this.longitude,
        required this.latitude,
        required this.mainWeather,
        required this.description,
        required this.temperature,
        required this.tempMax,
        required this.tempMin,
        required this.sunrise,
        required this.sunset,
        required this.humidity,
        required this.visibility,
        required this.windSpeed});

  factory WeatherData.fromJson(Map<String,dynamic> json){
    return WeatherData(
        cityName: json['name'],
        longitude: json['coord']['lon'].toString(),
        latitude: json['coord']['lat'].toString(),
        mainWeather: json['weather'][0]['main'].toString(),
        description: json['weather'][0]['description'].toString(),
        temperature: json['main']['temp'].toStringAsFixed(1),
        tempMax: json['main']['temp_max'].toStringAsFixed(1),
        tempMin: json['main']['temp_min'].toStringAsFixed(1),
        sunrise: DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(
            json['sys']['sunrise'] * 1000)),
        sunset: DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(
            json['sys']['sunset'] * 1000)),
        humidity: json['main']['humidity'].toString(),
        visibility: json['visibility'].toString(),
        windSpeed: json['wind']['speed'].toString());
  }
}
