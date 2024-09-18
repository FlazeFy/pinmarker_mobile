import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:pinmarker/services/modules/global/models.dart';

class QueriesGlobalListServices {
  final String baseUrl = "https://pinmarkerpy.leonardhors.com";
  final String localUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<GlobalListSearchModel>> getAllGlobalSearch(String search) async {
    final response = await client.get(
      Uri.parse("$localUrl/api/v1/pin_global/$search"),
    );
    if (response.statusCode == 200) {
      return globalListSearchModelFromJson(response.body);
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>?> getMyGlobalListDetail(String id) async {
    final response = await client.get(
      Uri.parse(
          "$localUrl/api/v1/pin_global/$id/fcd3f23e-e5aa-11ee-892a-3216422910e9"),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      GlobalListDetailModel detail =
          GlobalListDetailModel.fromJson(jsonData['detail']);

      List<GlobalListRelPinModel> data =
          globalListRelPinModelFromJson(jsonData['data']);

      return {
        'detail': detail,
        'data': data,
      };
    } else {
      return null;
    }
  }
}
