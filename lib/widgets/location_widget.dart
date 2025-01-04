import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  late double _deviceWidth, _deviceHeight;
  final String lon, lat;

  final Color color;

  LocationWidget({required this.lon, required this.lat, required this.color});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: _deviceWidth,
      height: _deviceHeight * 0.12,
      child: Stack(alignment: Alignment.center, children: [
        Row(
          children: [
            Expanded(
                flex: 1,
                child: containerWidget(title: "Longitude", value: lon)),
            SizedBox(
              width: 40,
            ),
            Expanded(
                flex: 1, child: containerWidget(title: "Latitude", value: lat)),
          ],
        ),
        Container(
          width: _deviceWidth,
          height: _deviceHeight * 0.3,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/icons/earth.png")),
          ),
        )
      ]),
    );
  }

  Widget containerWidget({required String title, required String value}) {
    return Container(
      height: _deviceHeight * 0.08,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color,
              Colors.black54,
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontSize: 15.0, color: Colors.white)),
          SizedBox(
            height: _deviceHeight * 0.01,
          ),
          Text(
            value,
            style:  TextStyle(fontSize: 15.0, color: Colors.white),
          )
        ],
      ),
    );
  }
}
