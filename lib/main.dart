import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/screen/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeScreen(),
      title: 'Weather App ',
      debugShowCheckedModeBanner: false,
    );
  }
}
