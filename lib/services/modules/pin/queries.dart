import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' show Client;
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/pin/models.dart';
import 'package:pinmarker/services/sqlite/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QueriesPinServices {
  final String baseUrl = "https://pinmarkerpy.leonardhors.com";
  final String localUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<PinModelHeader>?> getAllPinHeader() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    final response = await client.get(
      Uri.parse("$localUrl/api/v1/pin/fcd3f23e-e5aa-11ee-892a-3216422910e9"),
    );

    if (connectivityResult == ConnectivityResult.none) {
      if (prefs.containsKey("all-pin-header-sess")) {
        final data = prefs.getString("all-pin-header-sess");
        if (data != null) {
          if (!isOffline) {
            Get.snackbar("Warning", "Lost connection, all data shown are local",
                backgroundColor: Colors.white,
                borderColor: Colors.black,
                borderWidth: spaceMini / 2.5);
            isOffline = true;
          }
          return pinModelHeaderFromJson(data);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      if (response.statusCode == 200) {
        if (isOffline) {
          Get.snackbar("Information", "Welcome back, all data are now realtime",
              backgroundColor: Colors.white,
              borderColor: Colors.black,
              borderWidth: spaceMini / 2.5);
          isOffline = false;
        }
        prefs.setString("all-pin-header-sess", response.body);
        return pinModelHeaderFromJson(response.body);
      } else {
        if (prefs.containsKey("all-pin-header-sess")) {
          final data = prefs.getString("all-pin-header-sess");
          if (data != null) {
            return pinModelHeaderFromJson(data);
          } else {
            return null;
          }
        } else {
          return null;
        }
      }
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

  Future<Map<String, dynamic>?> getDetailPin(String id) async {
    final response = await client.get(
      Uri.parse(
          "$localUrl/api/v1/pin/detail/$id/fcd3f23e-e5aa-11ee-892a-3216422910e9"),
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      PinDetailModel detail = PinDetailModel.fromJson(jsonData['data']);
      List<VisitHistoryModel> history =
          visitHistoryModelFromJson(jsonData['history']);

      return {
        'detail': detail,
        'history': history,
      };
    } else {
      return null;
    }
  }

  Future<List<DistancePersonalModel>> getDistanceToMyPersonalPin(
      String id) async {
    final response = await client.get(
      Uri.parse(
          "$localUrl/api/v1/pin/distance/personal/$id/fcd3f23e-e5aa-11ee-892a-3216422910e9"),
    );
    if (response.statusCode == 200) {
      return distancePersonalModelFromJson(response.body);
    } else {
      return [];
    }
  }
}