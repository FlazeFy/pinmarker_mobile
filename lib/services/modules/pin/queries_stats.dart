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
}
