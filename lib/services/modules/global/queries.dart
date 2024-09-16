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
}
