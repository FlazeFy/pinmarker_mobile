import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/commands.dart';

class AuthCommandsService {
  final String baseUrl = "http://10.0.2.2:8080";
  Client client = Client();

  Future<List<Map<String, dynamic>>> postLogin(LoginModel data) async {
    final response = await client.post(
      Uri.parse("$baseUrl/api/v1/auth/login"),
      headers: {"content-type": "application/json"},
      body: loginModelToJson(data),
    );

    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', responseData['data']['token']);
    }

    return [
      {
        "status": response.statusCode == 200 ? "success" : "failed",
        "message": response.statusCode != 500 ? responseData['message'] : "Unknown error"
      }
    ];
  }
}