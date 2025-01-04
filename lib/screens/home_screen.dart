import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_node/controllers/color_controller.dart';
import 'package:weather_node/controllers/weather_controller.dart';
import 'package:weather_node/model/weather_data.dart';
import 'package:weather_node/utils/app_colors.dart';
import 'package:weather_node/widgets/detail_widget.dart';
import 'package:weather_node/widgets/location_widget.dart';
import 'package:weather_node/widgets/search_bar_widget.dart';
import 'package:weather_node/widgets/weather_image_widget.dart';

class HomeScreen extends StatefulWidget {
  final Position position;

  HomeScreen({required this.position});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _deviceWidth, _deviceHeight;
  late final WeatherController weatherController;
  late final ColorController colorController;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherController = Get.put(WeatherController());
    colorController = Get.put(ColorController());
    weatherController.weatherData = weatherController.getWeather(
        widget.position.latitude.toString(),
        widget.position.longitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: GetBuilder<WeatherController>(
        init: WeatherController(),
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.blackColor,
          body: Container(
            height: _deviceHeight,
            padding: EdgeInsets.symmetric(
                vertical: _deviceHeight * 0.01,
                horizontal: _deviceWidth * 0.02),
            child: Column(
              children: [
                SizedBox(
                  width: _deviceWidth,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: _deviceWidth * 0.03),
                        height: _deviceHeight * 0.06,
                        child:
                            Image.asset("assets/images/logo/logo_letter.png"),
                      ),
                      Expanded(
                        child: SearchBarWidget(
                          searchController: searchController,
                          onSubmitted: (value) {
                            weatherController.weatherData = controller
                                .getWeatherByCityName(value.toString());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _deviceHeight * 0.05,
                ),
                Expanded(child: _weatherData())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _weatherData() {
    return FutureBuilder<WeatherData>(
      future: weatherController.weatherData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: snapshot.data.isNull
                  ? AppColors.whiteColor
                  : colorController.changeColor(snapshot.data!.mainWeather),
            ),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      weatherController.weatherData =
                          weatherController.getWeather(
                        widget.position.latitude.toString(),
                        widget.position.longitude.toString(),
                      );
                    });
                  },
                  child: Text("ssss"))
            ],
          );
        } else if (snapshot.hasData) {
          final weather = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _refreshWeatherData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  WeatherImageWidget(weatherType: weather.mainWeather),
                  _temperatureText(weather.temperature),
                  _cityName(weather.cityName),
                  _mainWeatherType(weather.mainWeather),
                  _tempLevel(weather.tempMax, weather.tempMin),
                  LocationWidget(
                      lon: weather.longitude,
                      lat: weather.latitude,
                      color: colorController.changeColor(weather.mainWeather)),
                  DetailWidget(
                      sunrise: weather.sunrise,
                      sunset: weather.sunset,
                      humidity: weather.humidity,
                      windSpeed: weather.windSpeed,
                      visibility: weather.visibility,
                      color: colorController.changeColor(weather.mainWeather))
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Text(
              "No data available",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      },
    );
  }

  Future<void> _refreshWeatherData() async {
    // Fetch the updated weather data
    setState(() {
      weatherController.weatherData = weatherController.getWeather(
        widget.position.latitude.toString(),
        widget.position.longitude.toString(),
      );
    });
    // Wait for the data to load (simulate loading time if needed)
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Widget _cityName(String cityName) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          Icons.location_on,
          color: Colors.white,
          size: 18,
        ),
        SizedBox(
          width: _deviceWidth * 0.008,
        ),
        Text(cityName,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70))
      ]),
    );
  }

  Widget _temperatureText(String temp) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        '$temp °C',
        style: const TextStyle(
            color: Colors.white70, fontSize: 50, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _mainWeatherType(String main) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        main,
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white70),
      ),
    );
  }

  Widget _tempLevel(String maxTemp, String minTemp) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          Icons.arrow_upward,
          color: Colors.white,
          size: 20,
        ),
        Text(
          '$maxTemp °c',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        SizedBox(
          width: _deviceWidth * 0.05,
        ),
        const Icon(
          Icons.arrow_downward,
          color: Colors.white,
          size: 20,
        ),
        Text(
          '$minTemp °c',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        )
      ]),
    );
  }
}
