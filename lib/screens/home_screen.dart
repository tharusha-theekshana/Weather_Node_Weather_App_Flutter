import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_node/controllers/color_controller.dart';
import 'package:weather_node/controllers/connection_controller.dart';
import 'package:weather_node/controllers/weather_controller.dart';
import 'package:weather_node/model/weather_data.dart';
import 'package:weather_node/utils/app_colors.dart';
import 'package:weather_node/widgets/detail_widget.dart';
import 'package:weather_node/widgets/error_data_widget.dart';
import 'package:weather_node/widgets/footer_widget.dart';
import 'package:weather_node/widgets/location_widget.dart';
import 'package:weather_node/widgets/weather_image_widget.dart';

import '../widgets/custom_app_bar_widget.dart';

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
  late final ConnectionController connectionController;

  final TextEditingController searchController = TextEditingController();
  late WeatherData? weatherDataExist;

  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherController = Get.put(WeatherController());
    colorController = Get.put(ColorController());
    connectionController = Get.put(ConnectionController());
    weatherController.getWeather(widget.position.latitude.toString(),
        widget.position.longitude.toString());

    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      _refreshWeatherData(weatherDataExist!.latitude.toString(),
          weatherDataExist!.longitude.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return await _showExitConfirmation();
      },
      child: GetBuilder<WeatherController>(
        init: WeatherController(),
        builder: (controller) => Scaffold(
          appBar: CustomAppBar(
            deviceWidth: _deviceWidth,
            deviceHeight: _deviceHeight,
            searchController: searchController,
            onLogoTap: () {
              _refreshWeatherData(
                  widget.position.latitude.toString(),
                  widget.position.longitude.toString());
            },
            onSearchSubmitted: (value) {
              controller.getWeatherByCityName(value.toString());
            },
          ),
          backgroundColor: AppColors.blackColor,
          body: Container(
            height: _deviceHeight * 0.98,
            padding: EdgeInsets.symmetric(
                vertical: _deviceHeight * 0.01,
                horizontal: _deviceWidth * 0.02),
            child: _weatherData(),
          ),
        ),
      ),
    );
  }

  Widget _weatherData() {
    return Obx(
      () {
        final weatherData = weatherController.weatherData.value;
        weatherDataExist = weatherData;

        if (weatherController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: weatherData.isNull
                  ? AppColors.whiteColor
                  : colorController.changeColor(weatherData!.mainWeather),
            ),
          );
        }

        if (weatherController.hasError.value) {
          return connectionController.isConnected
              ? ErrorDataWidget(
                  titleText: "No Data Found ... !",
                  subText: "Please search valid city name..",
                  icon: const Icon(
                    Icons.info_outline,
                    color: AppColors.whiteColor,
                    size: 35.0,
                  ),
                )
              : ErrorDataWidget(
                  titleText: "No Internet Connection",
                  subText: "",
                  icon: const Icon(
                    Icons.signal_wifi_connected_no_internet_4,
                    color: AppColors.whiteColor,
                    size: 35.0,
                  ),
                );
        }

        if (weatherData == null) {
          return ErrorDataWidget(
            titleText: "No Data Found ... !",
            subText: "Please search valid city name..",
            icon: const Icon(
              Icons.info_outline,
              color: AppColors.whiteColor,
              size: 35.0,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () =>
              _refreshWeatherData(weatherData.latitude, weatherData.longitude),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                WeatherImageWidget(weatherType: weatherData.mainWeather),
                _temperatureText(weatherData.temperature),
                _cityName(weatherData.cityName),
                _mainWeatherType(weatherData.mainWeather),
                _tempLevel(weatherData.tempMax, weatherData.tempMin),
                LocationWidget(
                    lon: weatherData.longitude,
                    lat: weatherData.latitude,
                    color:
                        colorController.changeColor(weatherData.mainWeather)),
                DetailWidget(
                    sunrise: weatherData.sunrise,
                    sunset: weatherData.sunset,
                    humidity: weatherData.humidity,
                    windSpeed: weatherData.windSpeed,
                    visibility: weatherData.visibility,
                    rain: weatherData.rain,
                    snow: weatherData.snow,
                    cloud: weatherData.clouds,
                    color:
                        colorController.changeColor(weatherData.mainWeather)),
                SizedBox(
                  height: _deviceHeight * 0.04,
                ),
                FooterWidget()
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _refreshWeatherData(String lat, String lon) async {
    weatherController.getWeather(lat, lon);
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<bool> _showExitConfirmation() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.blackColor,
        title: const Text(
          'Exit',
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor),
        ),
        content: const Text(
          'Are you sure you want to exit from the app ?',
          style: TextStyle(color: AppColors.whiteColor, fontSize: 14.0),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'No',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              exit(0);
            },
            child: const Text(
              'Yes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white70))
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
