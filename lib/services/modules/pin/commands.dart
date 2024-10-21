import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;
import 'package:pinmarker/services/modules/pin/models.dart';

class PinCommandsService {
  final String baseUrl = "https://pinmarkerpy.leonardhors.com";
  final String localUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<Map<String, dynamic>> softDeletePin(String id) async {
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

  Future<Map<String, dynamic>> hardDeletePin(String id) async {
    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
    };
    final response = await client.delete(
        Uri.parse(
            "$localUrl/api/v1/pin/hard_del/$id/fcd3f23e-e5aa-11ee-892a-3216422910e9"),
        headers: header);

    var responseData = jsonDecode(response.body);

    return {
      "code": response.statusCode,
      "message": responseData["message"],
    };
  }

  Future<Map<String, dynamic>> toggleFavoritePin(String id) async {
    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
    };
    final response = await client.put(
        Uri.parse(
            "$localUrl/api/v1/pin/toggle_favorite/$id/fcd3f23e-e5aa-11ee-892a-3216422910e9"),
        headers: header);

    var responseData = jsonDecode(response.body);

    return {
      "code": response.statusCode,
      "message": responseData["message"],
    };
  }

  Future<Object> postPin(PinModel data) async {
    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
    };
    final response = await client.post(
      Uri.parse("$localUrl/api/v1/pin"),
      headers: header,
      body: pinModelToJson(data),
    );

    var responseData = jsonDecode(response.body);
    if ([201, 400, 401, 422, 500].contains(response.statusCode)) {
      return {
        "code": response.statusCode,
        "message": response.statusCode != 422
            ? responseData["message"]
            : responseData['errors'],
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
