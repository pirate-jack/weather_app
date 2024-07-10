import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/api/fetch_weather_api.dart';
import 'package:weather_app/contoller/global_contoller.dart';
import 'package:weather_app/model/weather_model.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = '';
  String date = DateFormat('yMMMMd').format(DateTime.now());

  WeatherData? weatherData;

  final GlobalContoller globalContoller =
      Get.put(GlobalContoller(), permanent: true);

  @override
  void initState() {
    getAddress(globalContoller.getLatitude().value,
        globalContoller.getLongitude().value);
    myWeather();

    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  myWeather() {
    WeatherFetcher()
        .getData(globalContoller.getLatitude().value,
            globalContoller.getLongitude().value)
        .then((newValue) {
      setState(() {
        weatherData = newValue;
      });
    });
  }

  Widget build(BuildContext context) {
    return weatherData == null
        ? Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
              ],
            ), // Loading indicator or placeholder
          )
        : Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weatherData!.sys!.country.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      city,
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 20, bottom: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                  child: Column(
                children: [
                  Image.network(
                    "http://openweathermap.org/img/wn/${weatherData!.weather[0].icon}@2x.png",
                    scale: 1 / 2,
                  /*  height: 200,
                    width: 200,*/
                  ),
                ],
              )),
              Container(
                child: Column(
                  children: [
                    Text(
                      "${(weatherData!.main!.temp! - 273.15).toStringAsFixed(0)} °C",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "H:${(weatherData!.main!.tempMax! - 273.15).toStringAsFixed(0)} °C",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                              'L:${(weatherData!.main!.tempMin! - 273.15).toStringAsFixed(0)} °C',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20)),
                        ],
                      ),
                    ),
                    Text(
                      weatherData!.weather[0].main,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      weatherData!.weather[0].description.toUpperCase(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          fit: BoxFit.cover,
                          'android/assets/images/h1.png',
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          'Humidity',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text('${weatherData!.main!.humidity.toString()}%'),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          fit: BoxFit.cover,
                          'android/assets/images/wind.png',
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          'Wind',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text('${weatherData!.wind!.speed.toString()}%'),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          fit: BoxFit.cover,
                          'android/assets/images/thermometer.png',
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          'Pressure',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text('${weatherData!.main!.pressure} Pa'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'android/assets/images/sea.png',
                            height: 50,
                            width: 50,
                          ),
                          Text(
                            'Sea Level',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          Text(
                            '${weatherData!.main!.seaLevel} hPa',
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'android/assets/images/l.png',
                            height: 50,
                            width: 50,
                          ),
                          Text(
                            'Ground Level',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          Text('${weatherData!.main!.grndLevel} hPa'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Column(
                  children: [
                    Image.asset(
                      'android/assets/images/clouds.png',
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      'Cloudiness %',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    Text('${weatherData!.clouds!.all}%'),
                  ],
                ),
              )
            ],
          );
  }
}
