
import 'dart:convert';
import 'dart:io';

import 'package:save_me/src/features/authentication/model/user_model.dart';
import 'package:http/http.dart' as http;


class ApiClient {
  // register User Api request
  Future<bool> registerUser(User user) async {
    const url = 'https://api-saveme.dev.fillflix.de/auth/register';
    final response = await http.post(
      Uri.parse(url),
      body:jsonEncode(user.toJson()),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader:'application/json, text/plain, */*',
        HttpHeaders.connectionHeader:'keep-alive'
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Success Response");
      return true;
    } else {
      print("Error Failed Response ${response.statusCode}");
    }
    return false;
  }

  // login User Api request
  Future<User?> loginUser(String email, String password) async {
    const url = 'https://api-saveme.dev.fillflix.de/auth/login';
    final body = jsonEncode({
      'email': email,
      'password': password,
    });
    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader:'application/json, text/plain, */*',
        HttpHeaders.connectionHeader:'keep-alive'
      },
    );

    if (response.statusCode == 200) {

      final Map<String, dynamic> userData = json.decode(response.body);
      final user = User.fromJson(userData);
      return user;

    } else {
      print("Erorr ");
          return null; // Login failed
    }
  }

}