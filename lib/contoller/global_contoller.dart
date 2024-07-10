import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/model/curretn_weather_model.dart';

class GlobalContoller extends GetxController {
  final RxBool _isLoding = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  RxBool checkLoding() => _isLoding;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  @override
  void onInit() {
    if (_isLoding.isTrue) {
      getLocation();
    }
    super.onInit();
  }
  late WeatherData weatherData;

  void getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error('Location not enable');
    }
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Location Permission deniedForever');
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location Permission denied');
      }
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high).then((value){
         _latitude.value = value.latitude;
         _longitude.value = value.longitude;
         _isLoding.value = false;
    });
  }

}
