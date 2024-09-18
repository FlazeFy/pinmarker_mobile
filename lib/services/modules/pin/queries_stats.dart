import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:pinmarker/services/modules/pin/models.dart';
import 'package:pinmarker/services/sqlite/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? lastPinRecord = prefs.getString('last_pin_record');
    if (lastPinRecord != null) {
      final dbHelper = DatabaseHelper();
      final data = await dbHelper.getAllPinLocal();

      return List<PinModelNearestHeader>.from(
        data.map((item) => PinModelNearestHeader(
              pinName: item['pin_name'],
              pinCoor: item['pin_coor'],
              pinCategory: item['pin_category'],
              distance: 0.0,
            )),
      );
    } else {
      final response = await client.post(
        Uri.parse("$localUrl/api/v1/pin/nearest/$lat/$long"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_id": "fcd3f23e-e5aa-11ee-892a-3216422910e9",
          "max_distance": 3000,
          "limit": 5,
        }),
      );

      if (response.statusCode == 200) {
        final dbHelper = DatabaseHelper();
        final jsonData = json.decode(response.body)['data'];

        await dbHelper.resetPinLocal();
        for (var data in jsonData) {
          await dbHelper.insertPinLocal(
            pinName: data['pin_name'],
            pinCoor: data['pin_coor'],
            pinCategory: data['pin_category'],
            storedAt: DateTime.now().toString(),
          );
        }

        prefs.setString('last_pin_record', DateTime.now().toString());
        return pinModelNearestHeaderFromJson(response.body);
      } else {
        return [];
      }
    }
  }
}
