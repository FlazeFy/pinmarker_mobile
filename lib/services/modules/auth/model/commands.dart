import 'dart:convert';

class LoginModel {
  String username;
  String password;

  LoginModel({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {"username": username, "password": password};
  }
}

String loginModelToJson(LoginModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}