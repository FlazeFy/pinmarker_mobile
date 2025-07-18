import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;

class TrackCommandsService {
  final String baseUrl = "https://pinmarker-go.leonardhors.com";
  final String localUrl = "http://10.0.2.2:9001";
  Client client = Client();

  // Send to BE Gin
  Future<dynamic> postTrack(List<Map<String, dynamic>> dataList) async {
    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await client.post(
      Uri.parse("$localUrl/api/v1/tracks/multi"),
      headers: header,
      body: json.encode(dataList),
    );

    var responseData = jsonDecode(response.body);
    if ([201, 400, 404, 500].contains(response.statusCode)) {
      return {
        "code": response.statusCode,
        "message": responseData["message"],
        "data": response.statusCode == 201 ? responseData["data"] : null,
      };
    } else {
      return {
        "code": "error",
        "message": "something wrong. please contact admin"
      };
    }
  }
}
