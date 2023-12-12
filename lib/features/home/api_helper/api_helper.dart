import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/api_endpoints.dart';
import '../models/profile_info.dart';
import 'package:http/http.dart' as http;

Future<bool> postProfileData(ProfileInfo profileInfo) async {
  const url = Endpoints.profiles;
  String? accessToken = await getAccessToken();

  final headers = {
    'Content-Type': 'application/json',
    'Accept': '*/*',
    'Authorization': 'Bearer $accessToken',
  };

  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: json.encode(profileInfo.toJson()),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    if (kDebugMode) {
      print("Success Response");
    }
    return true;
  } else {
    if (kDebugMode) {
      print("Error Failed Response: ${response.statusCode}");
      print("url: $url");
      print("asss: $accessToken");

    }
  }
  return false;
}

// Function to get the access token from SharedPreferences
Future<String?> getAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token');
}

// Function to set the access token in SharedPreferences
Future<void> setAccessToken(String accessToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', accessToken);
}