import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_node/controllers/connection_controller.dart';
import 'package:weather_node/controllers/location_controller.dart';
import 'package:weather_node/utils/app_colors.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late double _deviceWidth, _deviceHeight;
  late Position position;

  late final ConnectionController connectionController;
  late final LocationController locationController;

  @override
  void initState() {
    super.initState();
    connectionController = Get.put(ConnectionController());
    locationController = Get.put(LocationController());
  }


  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              height: _deviceHeight * 0.3,
              width: _deviceWidth * 0.6,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo/logo.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Connection Status Listener
          GetBuilder<ConnectionController>(
            builder: (controller) {
              if (!controller.isConnected) {
                Future.microtask(() => _showNoConnectionPopup());
              }else{
                Future.delayed(const Duration(seconds: 2), () async {
                  position = await locationController.fetchCurrentLocation();
                  Get.offAll(() => HomeScreen(position: position));
                });
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  void _showNoConnectionPopup() {
    Get.snackbar(
      "",
      "",
      titleText: Container(
        margin: EdgeInsets.only(left: 20.0),
        child: const Text(
          "No internet connection",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.0),
        ),
      ),
      messageText: Container(
        margin: const EdgeInsets.only(left: 20.0),
        child: const Text(
          "Please check your internet connection.",
          style: TextStyle(color: AppColors.whiteColor, fontSize: 12.0),
        ),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.redColor,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 5),
      icon: Container(
          margin: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: const Icon(
            Icons.warning_amber,
            color: AppColors.whiteColor,
          )),
    );
  }
}
