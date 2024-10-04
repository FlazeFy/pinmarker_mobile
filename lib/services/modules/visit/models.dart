import 'dart:convert';

class VisitModel {
  String id;
  String? visitDesc;
  String visitBy;
  String? visitWith;
  String? pinName;
  String createdAt;

  VisitModel(
      {required this.id,
      this.visitDesc,
      required this.visitBy,
      this.visitWith,
      this.pinName,
      required this.createdAt});

  factory VisitModel.fromJson(Map<String, dynamic> map) {
    return VisitModel(
        id: map["id"],
        visitDesc: map["visit_desc"] ?? '',
        visitBy: map["visit_by"],
        visitWith: map["visit_with"] ?? '',
        pinName: map['pin_name'] ?? '',
        createdAt: map["created_at"]);
  }
}

List<VisitModel> visitModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<VisitModel>.from(
      data['data'].map((item) => VisitModel.fromJson(item)));
}
