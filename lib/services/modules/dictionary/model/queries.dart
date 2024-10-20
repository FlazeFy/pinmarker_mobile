import 'dart:convert';

class DctModel {
  String dctName;
  String? dctColor;

  DctModel({required this.dctName, this.dctColor});

  factory DctModel.fromJson(Map<String, dynamic> map) {
    return DctModel(
        dctName: map["dictionary_name"],
        dctColor: map["dictionary_color"] ?? '');
  }
}

List<DctModel> dctModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<DctModel>.from(
      data['data'].map((item) => DctModel.fromJson(item)));
}
