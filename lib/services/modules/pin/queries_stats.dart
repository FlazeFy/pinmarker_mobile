import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:pinmarker/services/modules/pin/models.dart';

class QueriesPinServices {
  final String baseUrl = "https://pinmarkerpy.leonardhors.com";
  final String localUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<PinModelHeader>?> getAllPinHeader() async {
    final response = await client.get(
      Uri.parse("$localUrl/api/v1/pin/fcd3f23e-e5aa-11ee-892a-3216422910e9"),
    );
    if (response.statusCode == 200) {
      return pinModelHeaderFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<PinModelNearestHeader>> getAllNearestPinHeader(
      String lat, String long) async {
    final response = await client.post(
      Uri.parse("$localUrl/api/v1/pin/nearest/$lat/$long"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "user_id": "fcd3f23e-e5aa-11ee-892a-3216422910e9",
        "max_distance": 3000,
        "limit": 5
      }),
    );

    if (response.statusCode == 200) {
      return pinModelNearestHeaderFromJson(response.body);
    } else {
      return [];
    }
  }
}
