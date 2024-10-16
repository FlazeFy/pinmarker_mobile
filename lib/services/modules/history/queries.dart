import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' show Client;
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/services/modules/history/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QueriesHistoryServices {
  final String baseUrl = "https://pinmarkerpy.leonardhors.com";
  final String localUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<List<HistoryModel>?> getAllHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final connectivityResult = await (Connectivity().checkConnectivity());
    final response = await client.get(
      Uri.parse(
          "$localUrl/api/v1/history/fcd3f23e-e5aa-11ee-892a-3216422910e9"),
    );

    if (connectivityResult == ConnectivityResult.none) {
      if (prefs.containsKey("history-sess")) {
        final data = prefs.getString("history-sess");
        if (data != null) {
          if (!isOffline) {
            Get.snackbar("Warning", "Lost connection, all data shown are local",
                backgroundColor: whiteColor,
                borderColor: primaryColor,
                borderWidth: spaceMini / 2.5);
            isOffline = true;
          }
          return historyModelFromJson(data);
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
              backgroundColor: whiteColor,
              borderColor: primaryColor,
              borderWidth: spaceMini / 2.5);
          isOffline = false;
        }
        prefs.setString("history-sess", response.body);
        return historyModelFromJson(response.body);
      } else {
        if (prefs.containsKey("history-sess")) {
          final data = prefs.getString("history-sess");
          if (data != null) {
            return historyModelFromJson(data);
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
