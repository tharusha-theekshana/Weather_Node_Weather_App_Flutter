import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_node/utils/app_colors.dart';

class ColorController extends GetxController{

  Color color = Colors.blue;

  Color changeColor(weather) {
    if (weather == "Clear") {
      return AppColors.yellowColor;
    } else if (weather == "Clouds") {
      return AppColors.blueColor;
    }else if (weather == "Rain") {
      return AppColors.darkBlueColor;
    }else if (weather == "Fog") {
      return AppColors.grayColor;
    }else if (weather == "Thunderstorm") {
      return AppColors.purpleColor;
    } else {
      return AppColors.redColor;
    }
  }
}