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

class LastTrackModel {
  int batteryIndicator;
  String trackType;
  double trackLat;
  double trackLong;
  String createdAt;

  LastTrackModel(
      {required this.batteryIndicator,
      required this.trackType,
      required this.createdAt,
      required this.trackLat,
      required this.trackLong});

  factory LastTrackModel.fromJson(Map<dynamic, dynamic> map) {
    return LastTrackModel(
        batteryIndicator: map['battery_indicator'],
        trackLat: map['track_lat'],
        trackLong: map['track_long'],
        createdAt: map['created_at'],
        trackType: map['track_type']);
  }
}

LastTrackModel lastTrackModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return LastTrackModel.fromJson(data['data_track']);
}

List<LastTrackModel> trackModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<LastTrackModel>.from(
      data['data'].map((item) => LastTrackModel.fromJson(item)));
}
