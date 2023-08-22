import 'package:geolocator/geolocator.dart';

import 'getAddress.dart';
import 'network.dart';

var api_key = "6e3f5d9a8c5021400df10f5f222410ec";

class GetWeatherDatas {
  Future<dynamic> LocationWeather() async {
    Position position = await getLonLat();
    var latitude = position.latitude;
    var longitude = position.longitude;

    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$api_key&units=metric";

    Network network = Network(url);
    var data = await network.collectData();
    return data;
  }

  Future CityWeather(String cityName) async {
    var urlcity =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$api_key&units=metric";

    Network network = Network(urlcity);
    var data = await network.collectData();
    return data;
  }
}
