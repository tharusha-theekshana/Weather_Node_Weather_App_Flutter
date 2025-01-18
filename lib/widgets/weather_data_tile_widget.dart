import 'package:flutter/material.dart';

import '../utils/app_colors.dart';


class WeatherDataTileWidget extends StatelessWidget {
  final String imageUrl, text, value;
  final Color color;

  WeatherDataTileWidget({
    super.key,
    required this.imageUrl,
    required this.text,
    required this.value,
    required this.color
  });

  late double _deviceWidth, _deviceHeight;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: _deviceWidth * 0.25,
      height: _deviceHeight * 0.25,
      margin: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.01),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [
              color,
              AppColors.grayColor
            ],
          )),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imageUrl,height: _deviceHeight * 0.08),
            SizedBox(
              height: _deviceHeight * 0.03,
            ),
            Text(
              text,
              style:  const TextStyle(fontSize: 14.0,fontWeight: FontWeight.w600),
               textAlign: TextAlign.center,
            ),
            SizedBox(
              height: _deviceHeight * 0.005,
            ),
            Text(
              value,
              style:  const TextStyle(fontSize: 14.0,fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
