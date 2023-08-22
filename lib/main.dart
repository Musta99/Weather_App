import 'package:dailyweather/weather.dart';

import 'LocationScreen.dart';
import 'network.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'getAddress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(
    MaterialApp(
      home: DailyWeather(),
    ),
  );
}

class DailyWeather extends StatefulWidget {
  const DailyWeather({Key? key}) : super(key: key);

  @override
  State<DailyWeather> createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  @override
  void initState() {
    super.initState();
    getWeather();
  }

  void getWeather() async {
    GetWeatherDatas getWeatherDatas = GetWeatherDatas();
    var data = await getWeatherDatas.LocationWeather();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          weatherValues: data,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("Images/location_background.png"),
          ),
        ),
        child: SpinKitThreeBounce(
          color: Colors.amber,
          size: 50.0,
        ),
      ),
    );
  }
}
