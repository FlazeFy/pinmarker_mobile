import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:pinmarker/services/modules/pin/models.dart';
import 'package:pinmarker/services/modules/track/models.dart';

class QueriesTrackServices {
  final String baseUrl = "https://pinmarkerpy.leonardhors.com";
  final String localUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<Map<String, dynamic>?> getRelatedPinXTrackPin() async {
    final response = await client.get(
      Uri.parse(
          "$localUrl/api/v1/track/last_x_pin/fcd3f23e-e5aa-11ee-892a-3216422910e9"),
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      LastTrackModel track = LastTrackModel.fromJson(jsonData['data_track']);
      List<RelatedPinModel> relatedPin =
          relatedPinModelFromJson(jsonData['data_related_pin']);

      return {
        'data_track': track,
        'data_related_pin': relatedPin,
      };
    } else {
      return null;
    }
  }

  Future<List<LastTrackModel>> getTrackHistoryPeriod() async {
    final response = await client.post(
        Uri.parse(
            "$localUrl/api/v1/track/journey/period/fcd3f23e-e5aa-11ee-892a-3216422910e9"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "start_time": "2024-06-10T10:20:00",
          "end_time": "2024-06-11T00:00:00"
        }));
    if (response.statusCode == 200) {
      return trackModelFromJson(response.body);
    } else {
      return [];
    }
  }
}
