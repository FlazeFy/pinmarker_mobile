import 'dart:convert';

import 'package:pinmarker/services/modules/location/model/air.dart';
import 'package:pinmarker/services/modules/location/model/weather.dart';

class CurrentWeatherModel {
  WeatherModel weather;
  AirModel air;

  CurrentWeatherModel({
    required this.weather,
    required this.air,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> map) {
    return CurrentWeatherModel(
      weather: WeatherModel.fromJson(map["weather"]),
      air: AirModel.fromJson(map["air"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "weather": weather.toJson(),
      "air": air.toJson(),
    };
  }
}

CurrentWeatherModel currentWeatherModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return CurrentWeatherModel.fromJson(data["data"]);
}

String currentWeatherModelToJson(CurrentWeatherModel data) {
  return json.encode(data.toJson());
}