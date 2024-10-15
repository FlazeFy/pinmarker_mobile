import 'dart:convert';

class DashboardModel {
  int totalMarker;
  int totalFavorite;
  String lastVisit;
  String mostVisit;
  String mostCategory;
  String lastAdded;

  DashboardModel(
      {required this.totalMarker,
      required this.totalFavorite,
      required this.lastVisit,
      required this.mostVisit,
      required this.mostCategory,
      required this.lastAdded});

  factory DashboardModel.fromJson(Map<String, dynamic> map) {
    return DashboardModel(
      totalMarker: map["total_marker"],
      totalFavorite: map["total_favorite"],
      lastVisit: map["last_visit"],
      mostVisit: map["most_visit"],
      mostCategory: map["most_category"],
      lastAdded: map["last_added"],
    );
  }
}

DashboardModel dashboardModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return DashboardModel.fromJson(data['data']);
}

class QueriesPieChartModel {
  String ctx;
  dynamic total;

  QueriesPieChartModel({required this.ctx, required this.total});

  factory QueriesPieChartModel.fromJson(Map<String, dynamic> map) {
    return QueriesPieChartModel(
      ctx: map["context"].toString(),
      total: map["total"],
    );
  }
}

List<QueriesPieChartModel> queriesPieChartModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<QueriesPieChartModel>.from(
      data['data'].map((item) => QueriesPieChartModel.fromJson(item)));
}
