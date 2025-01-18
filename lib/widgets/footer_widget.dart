import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  late double _deviceWidth, _deviceHeight;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
        width: _deviceWidth,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Developed by Tharusha Theekshana",
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600)),
            SizedBox(
              height: 5,
            ),
            Text("Version 1.0.0",
                style: TextStyle(fontSize: 10.0,fontWeight: FontWeight.w600)),
          ],
        ));
  }
}
