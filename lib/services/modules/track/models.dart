import 'dart:convert';

class AddTrackModel {
  double trackLat;
  double trackLong;
  int batteryIndicator;
  String trackType;
  String createdAt;

  AddTrackModel(
      {required this.trackLat,
      required this.trackLong,
      required this.trackType,
      required this.batteryIndicator,
      required this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      "track_lat": trackLat,
      "track_long": trackLong,
      "track_type": trackType,
      "battery_indicator": batteryIndicator,
      "created_at": createdAt,
    };
  }
}

String addTrackModelToJson(AddTrackModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
