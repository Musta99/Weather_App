import 'package:dailyweather/weather.dart';
import 'package:flutter/material.dart';
import 'search_page.dart';

import 'Constant.dart';
import 'bottom_button.dart';
import 'custompaint.dart';

class LocationScreen extends StatefulWidget {
  final weatherValues;
  const LocationScreen({
    Key? key,
    required this.weatherValues,
  }) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

var currentTime = DateTime.now();
var time = "${currentTime.hour}:${currentTime.minute}";
var amPm = currentTime.hour < 12 ? 'Am' : 'PM';

class _LocationScreenState extends State<LocationScreen> {
  GetWeatherDatas getWeatherDatas = GetWeatherDatas();
  late String cityName;
  late var temperature;
  late var valueH;
  late var valueWS;
  late var valueHT;
  late var valueLT;
  late String status;
  late String icon;

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherValues);
  }

  void updateUI(dynamic data) {
    setState(() {
      cityName = data['name'];
      var cTemp = data['main']['temp'];
      temperature = cTemp.toStringAsFixed(0);
      valueH = data['main']['humidity'];
      valueWS = data['wind']['speed'] * 3.6;
      valueHT = data['main']['temp_max'];
      valueLT = data['main']['temp_max'];
      status = data['weather'][0]['main'];
      icon = data['weather'][0]['icon'];
    });
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("Images/location_background.png"),
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(25, 50, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              var data =
                                  await getWeatherDatas.LocationWeather();
                              updateUI(data);
                            },
                            child: Icon(
                              Icons.location_on_sharp,
                              size: 30,
                            ),
                          ),
                          Text(
                            cityName,
                            style: CityNTextStyle,
                          )
                        ],
                      ),
                      Row(
                        children: [Icon(Icons.menu)],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 15, 25, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$temperature\u00B0",
                            style: TempTextStyle,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(
                                image: NetworkImage(
                                    "https://openweathermap.org/img/wn/$icon@2x.png"),
                              ),
                              Text(
                                status,
                                style: CityNTextStyle,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: 250,
                child: CustomPaint(
                  painter: CPShape(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.horizontal_rule_outlined,
                            size: 30,
                          ),
                          Text(
                            "Today's Weather",
                            style: CityNTextStyle,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image(
                                image: AssetImage(
                                  "Images/ic_humidity.png",
                                ),
                                height: 40,
                                width: 40,
                              ),
                              Text("$valueH")
                            ],
                          ),
                          Column(
                            children: [
                              Image(
                                image: AssetImage(
                                  "Images/ic_wind_speed.png",
                                ),
                                height: 40,
                                width: 40,
                              ),
                              Text(valueWS.toStringAsFixed(0))
                            ],
                          ),
                          Column(
                            children: [
                              Image(
                                image: AssetImage(
                                  "Images/high_temp.png",
                                ),
                                height: 40,
                                width: 40,
                              ),
                              Text(valueHT.toStringAsFixed(0))
                            ],
                          ),
                          Column(
                            children: [
                              Image(
                                image: AssetImage(
                                  "Images/low_temp.png",
                                ),
                                height: 40,
                                width: 40,
                              ),
                              Text(valueLT.toStringAsFixed(0))
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BottomButton(
                            icon: Icons.home,
                            label: "Home",
                          ),
                          BottomButton(
                            icon: Icons.settings,
                            label: "Setting",
                          ),
                          GestureDetector(
                            onTap: () async {
                              var typedCity = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchPage(),
                                ),
                              );
                              if (typedCity != Null) {
                                var data = await getWeatherDatas.CityWeather(
                                    typedCity);
                                updateUI(data);
                              }
                              ;
                            },
                            child: BottomButton(
                              icon: Icons.search,
                              label: "Search",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
