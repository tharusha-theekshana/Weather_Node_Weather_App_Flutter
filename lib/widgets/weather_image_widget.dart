import 'package:flutter/material.dart';

class WeatherImageWidget extends StatelessWidget {
  final String weatherType;

  late double _deviceWidth, _deviceHeight;

  WeatherImageWidget({required this.weatherType});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    if(weatherType == "Clear"){
      return _image("assets/images/icons/weather/clear.gif");
    }else if(weatherType == "Clouds"){
      return  _image("assets/images/icons/weather/clouds.gif");
    }else if(weatherType == "Rain"){
      return _image("assets/images/icons/weather/rain.gif");
    }else if(weatherType == "Fog"){
      return _image("assets/images/icons/weather/fog.gif");
    }else if(weatherType == "Thunderstorm"){
      return _image("assets/images/icons/weather/thunder.gif");
    }
    else{
      return _image("assets/images/icons/weather/clear-sky.gif");
    }
  }

  Widget _image(String url){
    return Image.asset(
      url,
      height: _deviceHeight * 0.12,
      width: _deviceWidth * 0.45,
      filterQuality: FilterQuality.high,
    );
  }
}
