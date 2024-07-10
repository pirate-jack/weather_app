import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/api/api_key.dart';
import 'package:weather_app/contoller/global_contoller.dart';
import 'package:weather_app/model/weather_model.dart';

String apiUrl(var lat, var lon) {
  String url;
  url =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
  return url;
}

final GlobalContoller globalContoller =
    Get.put(GlobalContoller(), permanent: true);

/*

class FetchWeatherApi {

  Future<WeatherData> getData(double lat, double lon) async {
    final response = await http.get(Uri.parse(apiUrl(lat, lon)));
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return WeatherData.fromJson(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load data');
    }
  }
}
*/

class WeatherFetcher {
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherData> getData(double lat, double lon) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$apiKey'));

      if (response.statusCode == 200) {
        return WeatherData.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }
}
