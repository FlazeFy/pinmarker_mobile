import 'dart:convert';

class PinModelHeader {
  String id;
  String pinName;
  String? pinDesc;
  String pinCoordinate;
  String pinCategory;
  String? pinPerson;
  int totalVisit;
  bool isFavorite;
  String? lastVisit;
  String createdAt;

  PinModelHeader(
      {required this.id,
      required this.pinName,
      this.pinDesc,
      required this.pinCoordinate,
      required this.pinCategory,
      this.pinPerson,
      required this.totalVisit,
      required this.isFavorite,
      this.lastVisit,
      required this.createdAt});

  factory PinModelHeader.fromJson(Map<dynamic, dynamic> map) {
    return PinModelHeader(
        id: map['id'],
        pinName: map["pin_name"],
        pinDesc: map["pin_desc"] ?? '',
        pinCoordinate: map["pin_coordinate"],
        pinCategory: map["pin_category"],
        pinPerson: map["pin_person"] ?? '',
        totalVisit: map["total_visit"],
        isFavorite: map["is_favorite"],
        lastVisit: map['last_visit'] ?? '',
        createdAt: map['created_at']);
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

class DistancePersonalModel {
  String id;
  String pinName;
  String? pinDesc;
  String pinLat;
  String pinLong;
  String createdAt;
  double distanceToMeters;

  DistancePersonalModel(
      {required this.id,
      required this.pinName,
      this.pinDesc,
      required this.pinLat,
      required this.pinLong,
      required this.createdAt,
      required this.distanceToMeters});

  factory DistancePersonalModel.fromJson(Map<String, dynamic> map) {
    return DistancePersonalModel(
        id: map['id'],
        pinName: map['pin_name'],
        pinDesc: map['pin_desc'] ?? '',
        pinLat: map['pin_lat'],
        pinLong: map['pin_long'],
        createdAt: map['created_at'],
        distanceToMeters: map['distance_to_meters']);
  }
}

List<DistancePersonalModel> distancePersonalModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<DistancePersonalModel>.from(
      data['data'].map((item) => DistancePersonalModel.fromJson(item)));
}

class PinTrashModel {
  String id;
  String pinName;
  int totalVisit;
  String createdAt;
  String? updatedAt;
  String deletedAt;

  PinTrashModel(
      {required this.id,
      required this.pinName,
      required this.totalVisit,
      required this.createdAt,
      this.updatedAt,
      required this.deletedAt});

  factory PinTrashModel.fromJson(Map<String, dynamic> map) {
    return PinTrashModel(
        id: map["id"],
        pinName: map["pin_name"],
        totalVisit: map["total_visit"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"] ?? '',
        deletedAt: map["deleted_at"]);
  }
}

List<PinTrashModel> pinTrashModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<PinTrashModel>.from(
      data['data'].map((item) => PinTrashModel.fromJson(item)));
}

class RelatedPinModel {
  String pinName;
  String pinLat;
  String pinLong;
  String pinCat;
  double distance;

  RelatedPinModel(
      {required this.pinName,
      required this.pinLat,
      required this.pinLong,
      required this.pinCat,
      required this.distance});

  factory RelatedPinModel.fromJson(Map<dynamic, dynamic> map) {
    return RelatedPinModel(
      pinName: map['pin_name'],
      pinLat: map['pin_lat'],
      pinLong: map['pin_long'],
      pinCat: map['pin_category'],
      distance: map['distance_to_meters'],
    );
  }
}

List<RelatedPinModel> relatedPinModelFromJson(dynamic data) {
  return List<RelatedPinModel>.from(
      data.map((item) => RelatedPinModel.fromJson(item)));
}

class PinModel {
  String pinName;
  String? pinDesc;
  String pinLat;
  String pinLong;
  String pinCategory;
  String? pinPerson;
  String? pinCall;
  String? pinEmail;
  String? pinAddress;
  int isFavorite;
  String createdBy;

  PinModel({
    required this.pinName,
    this.pinDesc,
    required this.pinLat,
    required this.pinLong,
    required this.pinCategory,
    this.pinPerson,
    this.pinCall,
    this.pinEmail,
    this.pinAddress,
    required this.isFavorite,
    required this.createdBy,
  });

  Map<String, dynamic> toJson() {
    return {
      "pin_name": pinName,
      "pin_desc": pinDesc,
      "pin_lat": pinLat,
      "pin_long": pinLong,
      "pin_category": pinCategory,
      "pin_person": pinPerson,
      "pin_call": pinCall,
      "pin_email": pinEmail,
      "pin_address": pinAddress,
      "is_favorite": isFavorite,
      "created_by": createdBy,
    };
  }
}

String pinModelToJson(PinModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
