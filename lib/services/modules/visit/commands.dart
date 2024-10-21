import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' show Client;
import 'package:pinmarker/services/modules/visit/models.dart';

class VisitCommandsService {
  final String baseUrl = "https://pinmarkerpy.leonardhors.com";
  final String localUrl = "http://10.0.2.2:8000";
  Client client = Client();

  Future<Object> postVisit(VisitModel data) async {
    final header = {
      'Accept': 'application/json',
      'content-type': 'application/json',
    };
    final response = await client.post(
      Uri.parse("$localUrl/api/v1/visit"),
      headers: header,
      body: visitModelToJson(data),
    );

    var responseData = jsonDecode(response.body);
    if ([201, 400, 401, 404, 422, 500].contains(response.statusCode)) {
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
