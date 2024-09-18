import 'dart:convert';

class PinModelHeader {
  String pinName;
  String? pinDesc;
  String pinCoordinate;
  String pinCategory;
  String? pinPerson;
  int totalVisit;
  String? lastVisit;

  PinModelHeader(
      {required this.pinName,
      this.pinDesc,
      required this.pinCoordinate,
      required this.pinCategory,
      this.pinPerson,
      required this.totalVisit,
      this.lastVisit});

  factory PinModelHeader.fromJson(Map<dynamic, dynamic> map) {
    return PinModelHeader(
        pinName: map["pin_name"],
        pinDesc: map["pin_desc"] ?? '',
        pinCoordinate: map["pin_coordinate"],
        pinCategory: map["pin_category"],
        pinPerson: map["pin_person"] ?? '',
        totalVisit: map["total_visit"],
        lastVisit: map['last_visit'] ?? '');
  }
}

List<PinModelHeader> pinModelHeaderFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<PinModelHeader>.from(
      data['data'].map((item) => PinModelHeader.fromJson(item)));
}

class PinModelNearestHeader {
  String pinName;
  String pinCoor;
  String pinCategory;
  double distance;

  PinModelNearestHeader(
      {required this.pinName,
      required this.pinCoor,
      required this.pinCategory,
      required this.distance});

  factory PinModelNearestHeader.fromJson(Map<String, dynamic> map) {
    return PinModelNearestHeader(
      pinName: map["pin_name"],
      pinCoor: map["pin_coor"],
      pinCategory: map["pin_category"],
      distance: map["distance"],
    );
  }
}

List<PinModelNearestHeader> pinModelNearestHeaderFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<PinModelNearestHeader>.from(
      data['data'].map((item) => PinModelNearestHeader.fromJson(item)));
}
