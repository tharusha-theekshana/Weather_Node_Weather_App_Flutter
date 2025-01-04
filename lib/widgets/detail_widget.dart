import 'package:flutter/material.dart';
import 'package:weather_node/widgets/weather_data_tile_widget.dart';

class DetailWidget extends StatelessWidget {

  final String sunrise,sunset,humidity,windSpeed,visibility;
  final Color color;
  late double _deviceHeight,_deviceWidth;

  DetailWidget({required this.sunrise,required this.sunset,required this.humidity,required this.windSpeed,
     required this.visibility,required this.color});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: _deviceHeight * 0.01),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            WeatherDataTileWidget(imageUrl: "assets/images/icons/sunrise.png",text: "Sunrise",value: sunrise,color: color,),
            WeatherDataTileWidget(imageUrl: "assets/images/icons/sunset.png",text: "Sunset",value: sunset,color: color),
            WeatherDataTileWidget(imageUrl: "assets/images/icons/humidity.png",text: "Humidity",value: humidity,color: color),
            WeatherDataTileWidget(imageUrl: "assets/images/icons/cloud.png",text: "Wind speed",value: windSpeed,color: color),
            WeatherDataTileWidget(imageUrl: "assets/images/icons/visibility.png",text: "Visibility",value: visibility,color: color)
          ],
        ),
      ),
    );
  }
}