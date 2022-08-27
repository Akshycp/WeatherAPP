import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weatherapp_starter_project/api/fetch_weather.dart';
import 'package:weatherapp_starter_project/models/weather_data.dart';

class GlobalController extends GetxController {
  //create variables
  final RxBool _isloading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentindex = 0.obs;
  //Instance for them to be called
  RxBool checkloading() => _isloading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;
  final weatherData = WeatherData().obs;
  WeatherData getWeatherData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isloading.firstRebuild) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  void getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //return if service is not enabled
    if (!isServiceEnabled) {
      print("locationPermission is not enabled");
      return Future.error("Location is not enabled");
    }
    //status of permission
    locationPermission = await Geolocator.checkPermission();
    // print(locationPermission);
    if (locationPermission == LocationPermission.deniedForever) {
      print("locationPermission is denied");
      return Future.error("Location Permission is denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      // request permission
      print("locationPermission is denied on click");
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        print("locationPermission is denied again $locationPermission");
        return Future.error("Location Permission is denied");
      }
    } else {
      print("locationPermission is enabled");

      return await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .then((value) {
        //update our current latitude and longitude
        _latitude.value = value.latitude;
        _longitude.value = value.longitude;
        _isloading.value = false;
        print(_latitude.value);
        print(_longitude.value);
        //calling the api
        FetchWeatherAPI()
            .processData(value.latitude, value.longitude)
            .then((value) {
          weatherData.value = value;
          _isloading.value = false;
        });
      });
    }
  }

  RxInt getIndex() {
    return _currentindex;
  }
}
