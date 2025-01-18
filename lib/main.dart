import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_node/screens/splash_screen.dart';
import 'package:weather_node/utils/app_colors.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final getStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'WeatherNode',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: getStorage.read("ThemeMode") == null ||
                getStorage.read("ThemeMode") != "dark"
            ? ThemeMode.light
            : ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
