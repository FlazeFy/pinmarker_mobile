import 'dart:convert';

class WeatherModel {
  double temperature;
  double feelsLike;
  int humidity;
  double windSpeed;
  int code;
  String unit;

  WeatherModel({
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.code,
    required this.unit,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> map) {
    return WeatherModel(
      temperature: (map["temperature"] as num).toDouble(),
      feelsLike: (map["feels_like"] as num).toDouble(),
      humidity: map["humidity"],
      windSpeed: (map["wind_speed"] as num).toDouble(),
      code: map["code"],
      unit: map["unit"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "temperature": temperature,
      "feels_like": feelsLike,
      "humidity": humidity,
      "wind_speed": windSpeed,
      "code": code,
      "unit": unit,
    };
  }
}

WeatherModel weatherModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return WeatherModel.fromJson(data["data"]["weather"]);
}

String weatherModelToJson(WeatherModel data) {
  return json.encode(data.toJson());
}