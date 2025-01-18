import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_node/controllers/connection_controller.dart';
import 'package:weather_node/controllers/location_controller.dart';
import 'package:weather_node/controllers/weather_controller.dart';

import '../screens/home_screen.dart';

class ErrorDataWidget extends StatelessWidget {
  late double _deviceWidth, _deviceHeight;
  final ConnectionController connectionController = ConnectionController();
  final LocationController locationController = LocationController();
  final WeatherController weatherController = WeatherController();

  late Position position;

  final String titleText;
  final String subText;
  final Icon icon;

  ErrorDataWidget({required this.titleText,required this.subText,required this.icon});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;


    return RefreshIndicator(
      onRefresh: () async {
        position = await locationController.fetchCurrentLocation();
        connectionController.isConnected ? Get.offAll(HomeScreen(position: position)) : print("No internet connection.");
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: _deviceHeight * 0.8,
          width: _deviceWidth,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              const SizedBox(
                height: 20,
              ),
              Text(
                titleText,
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                // "Please check your internet connection or search value is valid or not.",
                subText,
                style: const TextStyle(fontSize: 12.0),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
