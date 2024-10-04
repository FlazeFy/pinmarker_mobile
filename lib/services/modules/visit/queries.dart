import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' show Client;
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/visit/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QueriesVisitServices {
  final String baseUrl = "https://pinmarkerpy.leonardhors.com";
  final String localUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<VisitModel>?> getAllVisit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    final response = await client.get(
      Uri.parse("$localUrl/api/v1/visit/fcd3f23e-e5aa-11ee-892a-3216422910e9"),
    );

    if (connectivityResult == ConnectivityResult.none) {
      if (prefs.containsKey("visit-sess")) {
        final data = prefs.getString("visit-sess");
        if (data != null) {
          if (!isOffline) {
            Get.snackbar("Warning", "Lost connection, all data shown are local",
                backgroundColor: Colors.white,
                borderColor: Colors.black,
                borderWidth: spaceMini / 2.5);
            isOffline = true;
          }
          return visitModelFromJson(data);
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
        prefs.setString("visit-sess", response.body);
        return visitModelFromJson(response.body);
      } else {
        if (prefs.containsKey("visit-sess")) {
          final data = prefs.getString("visit-sess");
          if (data != null) {
            return visitModelFromJson(data);
          } else {
            return null;
          }
        } else {
          return null;
        }
      }
    }
  }
}
