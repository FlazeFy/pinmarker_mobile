import 'dart:convert';

class HistoryModel {
  String id;
  String historyType;
  String historyContext;
  String createdAt;

  HistoryModel(
      {required this.id,
      required this.historyType,
      required this.historyContext,
      required this.createdAt});

  factory HistoryModel.fromJson(Map<String, dynamic> map) {
    return HistoryModel(
        id: map["id"],
        historyType: map["history_type"],
        historyContext: map["history_context"],
        createdAt: map["created_at"]);
  }
}

List<HistoryModel> historyModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<HistoryModel>.from(
      data['data'].map((item) => HistoryModel.fromJson(item)));
}
