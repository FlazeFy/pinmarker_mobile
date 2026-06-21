import 'dart:convert';

class AirModel {
  int aqi;
  double pm25;
  double pm10;
  double co;
  double no2;

  AirModel({
    required this.aqi,
    required this.pm25,
    required this.pm10,
    required this.co,
    required this.no2,
  });

  factory AirModel.fromJson(Map<String, dynamic> map) {
    return AirModel(
      aqi: map["aqi"],
      pm25: (map["pm2_5"] as num).toDouble(),
      pm10: (map["pm10"] as num).toDouble(),
      co: (map["co"] as num).toDouble(),
      no2: (map["no2"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "aqi": aqi,
      "pm2_5": pm25,
      "pm10": pm10,
      "co": co,
      "no2": no2,
    };
  }
}

AirModel airModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return AirModel.fromJson(data["data"]["air"]);
}

String airModelToJson(AirModel data) {
  return json.encode(data.toJson());
}