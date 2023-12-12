// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:save_me/data/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/auth/models/user_model.dart';

class ApiClient {
  // register User Api request
  Future<String> registerUser(User user) async {
    const url = Endpoints.register;
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(user.toJson()),
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return "Registration Successful!";
    } else {
      throw Exception('Failed to register user');
    }
  }

  // login User Api request
  static Future<String> loginUser(String email, String password) async {
    const url = Endpoints.login;
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      // Store the user data token using shared_preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', responseData['access_token']);
      final user = await getUserProfileData(responseData['access_token']);
      prefs.setString('user', jsonEncode(user.toJson()));
      return "Login Successful!";
    } else {
      if (kDebugMode) {
        print("Error: ${response.statusCode}");
        print("Error Body: ${response.body}");
      }
      throw Exception("Login failed with status code ${response.statusCode}");
    }
  }

  static Future<User> getUserProfileData(String accessToken) async {
    const url = Endpoints.register;
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return User.fromJson(responseData);
      } else {
        throw Exception('Failed to load user profile data');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load user profile data');
    }
  }

  Future<dynamic> updateUserProfile({
    required String accessToken,
    required Map<String, dynamic> data,
  }) async {
    const String apiUrl = Endpoints.register;

    try {
      final http.Response response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update user profile');
      }
    } catch (error) {
      // Handle errors here
      print('Error: $error');
      return {'error': 'Failed to update user profile'};
    }
  }
}
