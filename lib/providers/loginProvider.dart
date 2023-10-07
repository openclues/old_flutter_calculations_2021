import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginRegister with ChangeNotifier {
  bool loggedin;

  Future signup(
      String email, String password, String username, String cpassword) async {
    http.Response response = await http.post(
        'https://buycheapkeys.com/api/register?name=$username&email=$email&password=$password&c_password=$cpassword');

    final data = jsonDecode(response.body);

    return data;
  }

  Future<bool> checkiftoken() async {
    final storage = await FlutterSecureStorage().read(key: 'token');

    if (storage == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> getToken() async {
    final storage = await FlutterSecureStorage().read(key: 'token');
    return storage;
  }

  logout() async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  getUserData() async {
    String token = await getToken();
    http.Response response = await http.get(
        'https://buycheapkeys.com/api/userdata',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    return jsonDecode(response.body);
  }
}
