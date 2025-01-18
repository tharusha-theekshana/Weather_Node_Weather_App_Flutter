import 'package:flutter/material.dart';

class AppColors{

  static const Color blackColor = Color.fromRGBO(41, 41, 41, 1.0);
  static const Color redColor = Color.fromRGBO(108, 26, 26, 1.0);
  static const Color whiteColor = Color.fromRGBO(221, 221, 221, 1.0);

  // Colors for weather types
  static const Color yellowColor = Color.fromRGBO(195, 195, 63, 1.0);
  static const Color blueColor = Color.fromRGBO(63, 160, 195, 1.0);
  static const Color darkBlueColor = Color.fromRGBO(41, 69, 181, 1.0);
  static const Color grayColor = Color.fromRGBO(129, 129, 129, 1.0);
  static const Color purpleColor = Color.fromRGBO(115, 28, 159, 1.0);
}

// Light Theme
final ThemeData lightTheme = ThemeData(
  fontFamily: "Poppins",
  brightness: Brightness.light,
  primaryColor: AppColors.whiteColor,
  scaffoldBackgroundColor: AppColors.whiteColor,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.blackColor),
    bodySmall: TextStyle(color: AppColors.blackColor),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.whiteColor,
    titleTextStyle: TextStyle(color: AppColors.whiteColor),
    iconTheme: IconThemeData(color: AppColors.whiteColor),
  ),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  fontFamily: "Poppins",
  brightness: Brightness.dark,
  primaryColor: AppColors.blackColor,
  scaffoldBackgroundColor: AppColors.blackColor,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.whiteColor),
    bodySmall:  TextStyle(color: AppColors.whiteColor),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.blackColor,
    titleTextStyle: TextStyle(color: AppColors.blackColor),
    iconTheme: IconThemeData(color: AppColors.blackColor),
  ),
);

