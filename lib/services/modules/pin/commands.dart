import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;

class PinCommandsService {
  final String baseUrl = "https://pinmarkerpy.leonardhors.com";
  final String localUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<Map<String, dynamic>> hardDeletePin(String id) async {
    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
    };
    final response = await client.delete(
        Uri.parse(
            "$localUrl/api/v1/pin/soft_del/$id/fcd3f23e-e5aa-11ee-892a-3216422910e9"),
        headers: header);

    var responseData = jsonDecode(response.body);

    return {
      "code": response.statusCode,
      "message": responseData["message"],
    };
  }

  Future<Map<String, dynamic>> recoverPin(String id) async {
    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
    };
    final response = await client.put(
        Uri.parse(
            "$localUrl/api/v1/pin/recover/$id/fcd3f23e-e5aa-11ee-892a-3216422910e9"),
        headers: header);

    var responseData = jsonDecode(response.body);

    return {
      "code": response.statusCode,
      "message": responseData["message"],
    };
  }
}
