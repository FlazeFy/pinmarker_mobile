import 'dart:convert';

class VisitModel {
  String? id;
  String? visitDesc;
  String visitBy;
  String? visitWith;
  String? pinName;
  String createdAt;
  String? createdBy;
  String? pinId;

  VisitModel(
      {this.id,
      this.visitDesc,
      required this.visitBy,
      this.visitWith,
      this.pinName,
      required this.createdAt,
      this.createdBy,
      this.pinId});

  factory VisitModel.fromJson(Map<String, dynamic> map) {
    return VisitModel(
        id: map["id"],
        visitDesc: map["visit_desc"] ?? '',
        visitBy: map["visit_by"],
        visitWith: map["visit_with"] ?? '',
        pinName: map['pin_name'] ?? '',
        createdAt: map["created_at"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "pin_id": pinId,
      "visit_desc": visitDesc,
      "visit_by": visitBy,
      "visit_with": visitWith,
      "created_by": createdBy,
      "created_at": createdAt
    };
  }
}

List<VisitModel> visitModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<VisitModel>.from(
      data['data'].map((item) => VisitModel.fromJson(item)));
}

String visitModelToJson(VisitModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
