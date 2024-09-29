import 'dart:convert';

class PinModelHeader {
  String id;
  String pinName;
  String? pinDesc;
  String pinCoordinate;
  String pinCategory;
  String? pinPerson;
  int totalVisit;
  String? lastVisit;

  PinModelHeader(
      {required this.id,
      required this.pinName,
      this.pinDesc,
      required this.pinCoordinate,
      required this.pinCategory,
      this.pinPerson,
      required this.totalVisit,
      this.lastVisit});

  factory PinModelHeader.fromJson(Map<dynamic, dynamic> map) {
    return PinModelHeader(
        id: map['id'],
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

class PinDetailModel {
  String pinName;
  String? pinDesc;
  String pinCategory;
  String pinLat;
  String pinLong;
  String? pinPerson;
  String? pinEmail;
  String? pinCall;
  String? pinAddress;
  String createdAt;
  String? updatedAt;

  PinDetailModel(
      {required this.pinName,
      this.pinDesc,
      required this.pinCategory,
      required this.pinLat,
      required this.pinLong,
      this.pinPerson,
      this.pinEmail,
      this.pinAddress,
      this.pinCall,
      required this.createdAt,
      this.updatedAt});

  factory PinDetailModel.fromJson(Map<String, dynamic> map) {
    return PinDetailModel(
      pinName: map['pin_name'],
      pinDesc: map['pin_desc'] ?? '',
      pinCategory: map['pin_category'],
      pinLat: map['pin_lat'],
      pinLong: map['pin_long'],
      pinPerson: map['pin_person'] ?? '',
      pinEmail: map['pin_email'] ?? '',
      pinCall: map['pin_call'] ?? '',
      pinAddress: map['pin_address'] ?? '',
      createdAt: map['created_at'],
      updatedAt: map['updated_at'] ?? '',
    );
  }
}

PinDetailModel pinDetailModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return PinDetailModel.fromJson(data['detail']);
}

class VisitHistoryModel {
  String? visitDesc;
  String visitBy;
  String? visitWith;
  String createdAt;

  VisitHistoryModel(
      {this.visitDesc,
      required this.visitBy,
      this.visitWith,
      required this.createdAt});

  factory VisitHistoryModel.fromJson(Map<String, dynamic> map) {
    return VisitHistoryModel(
      visitDesc: map['visit_desc'] ?? '',
      visitBy: map['visit_by'],
      visitWith: map['visit_with'] ?? '',
      createdAt: map['created_at'],
    );
  }
}

List<VisitHistoryModel> visitHistoryModelFromJson(dynamic data) {
  return List<VisitHistoryModel>.from(
      data.map((item) => VisitHistoryModel.fromJson(item)));
}
