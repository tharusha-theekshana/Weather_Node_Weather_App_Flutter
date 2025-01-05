import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_node/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'WeatherNode',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: "Poppins"),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
