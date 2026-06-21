import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' show Client;
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/location/model/current_weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherServices {
  final String baseUrl = "https://pinmarkerpy.leonardhors.com";
  final String localUrl = "http://10.0.2.2:8080";
  Client client = Client();

  Future<CurrentWeatherModel?> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final connectivityResult = await Connectivity().checkConnectivity();
    // Hit endpoint
    final response = await client.get(
      Uri.parse(
        "$localUrl/api/v1/location/weather?lat=$latitude&long=$longitude",
      ),
    );

    if (connectivityResult == ConnectivityResult.none) {
      if (prefs.containsKey("weather-current")) {
        // Take local storage
        final data = prefs.getString("weather-current");

        if (data != null) {
          if (!isOffline) {
            Get.snackbar(
              "Warning",
              "Lost connection, weather shown is cached",
              backgroundColor: whiteColor,
              borderColor: primaryColor,
              borderWidth: spaceMini / 2.5,
            );
            isOffline = true;
          }

          return currentWeatherModelFromJson(data);
        }

        return null;
      }

      return null;
    } else {
      if (response.statusCode == 200) {
        if (isOffline) {
          Get.snackbar(
            "Information",
            "Welcome back, weather is now realtime",
            backgroundColor: whiteColor,
            borderColor: primaryColor,
            borderWidth: spaceMini / 2.5,
          );

          isOffline = false;
        }

        // Store local storage
        await prefs.setString("weather-current", response.body,);
        await prefs.setString("weather-last-update", DateTime.now().toIso8601String(),);

        return currentWeatherModelFromJson(response.body);
      } else {
        // Take local storage
        if (prefs.containsKey("weather-current")) {
          final data = prefs.getString("weather-current");
          if (data != null) return currentWeatherModelFromJson(data);
        }

        return null;
      }
    }
  }

  Future<DateTime?> getLastUpdate(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    if (value == null) return null;

    return DateTime.tryParse(value);
  }
}