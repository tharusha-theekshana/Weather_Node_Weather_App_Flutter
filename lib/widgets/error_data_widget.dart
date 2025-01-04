import 'package:flutter/material.dart';
import 'package:weather_node/utils/app_colors.dart';

class ErrorDataWidget extends StatelessWidget {
  late double _deviceWidth, _deviceHeight;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            size: 45.0,
            color: AppColors.whiteColor,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "No Data Found ... !",
            style: TextStyle(
                fontSize: 18.0,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Please check your internet connection or search value is valid or not.",
            style: TextStyle(fontSize: 12.0, color: AppColors.whiteColor),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
