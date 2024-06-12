import 'package:http/http.dart' show Client;
import 'package:pinmarker/services/modules/stats/models.dart';

class QueriesStatsServices {
  final String baseUrl = "http://10.0.2.2:2000";
  Client client = Client();

  Future<DashboardModel?> getDashboard() async {
    final response = await client.get(
      Uri.parse(
          "$baseUrl/api/v1/stats/dashboard/fcd3f23e-e5aa-11ee-892a-3216422910e9"),
    );
    if (response.statusCode == 200) {
      return dashboardModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
