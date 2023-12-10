import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:save_me/data/api_endpoints.dart';

import '../features/auth/models/user_model.dart';


class ApiClient {

  // register User Api request
  Future<bool> registerUser(User user) async {
    const url = Endpoints.register;
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse(url),
      body:jsonEncode(user.toJson()),
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (kDebugMode) {
        print("Success Response");
      }
      return true;
    } else {
      if (kDebugMode) {
        print("Error Failed Response ${response.statusCode}");
      }
    }
    return false;
  }
  // login User Api request
  Future<User?> loginUser(String email, String password) async {
    const url = Endpoints.login;
    final body = jsonEncode({
      'email': email,
      'password': password,
    });
    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      final user = User.fromJson(userData);
      return user;

    } else {
        if (kDebugMode) {
          print("Error ");
        }
        return null;
    }
  }
  Future<dynamic> getUserProfileData(String accessToken) async {
    const url = Endpoints.register;
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load user profile data');
      }
    } catch (error) {
      print('Error: $error');
      return {'error': 'Failed to load user profile data'};
    }
  }

  Future<dynamic> updateUserProfile({
    required String accessToken,
    required Map<String, dynamic> data,
  }) async {
    const String apiUrl = Endpoints.register ;

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