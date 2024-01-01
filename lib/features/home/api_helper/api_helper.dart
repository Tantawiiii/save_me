import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/api_endpoints.dart';
import '../models/profile_info.dart';

Future<ProfileInfo?> postProfileData(ProfileInfo profileInfo) async {
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
    final data = jsonDecode(response.body);
    final profile = ProfileInfo.fromJson(data);
    return profile;
  } else {
    if (kDebugMode) {
      print("Error Failed Response: ${response.statusCode}");
      print("url: $url");
      print("asss: $accessToken");
    }
  }
  return null;
}

// get profile data

Future<List<ProfileInfo>> getUserProfileData() async {
  String? accessToken = await getAccessToken();
  const url = Endpoints.profiles;
  List<ProfileInfo> profiles = [];
  try {
    final http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      responseData.forEach((profile) {
        profiles.add(ProfileInfo.fromJson(profile));
      });

      print('Successfully Getting Profiles...');

      return profiles;
    } else {
      throw Exception('Failed to load user profile data');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('Failed to load user profile data');
  }
}

Future<void> updateProfile(String profileId, ProfileInfo updateInfo) async {
  String? accessToken = await getAccessToken();
  final String url = Endpoints.profileId(profileId);

  try {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(updateInfo.toJson()),
    );

    if (response.statusCode == 200) {
      // Successfully updated profile
      if (kDebugMode) {
        print('Profile updated successfully');
      }
    } else {
      if (kDebugMode) {
        print("Error: ${response.statusCode}");
        print("Error Body: ${response.body}");
      }
    }
  } catch (e) {
    // Handle exception
    print('Exception during profile update: $e');
  }
}

Future<void> deleteUserProfileData(String profileId) async {
  String? accessToken = await getAccessToken();
  final url = Endpoints.profileId(profileId);
  try {
    final http.Response response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
  } catch (error) {
    Fluttertoast.showToast(msg: "$error");
    throw Exception('Failed to load user profile data');
  }
}

Future<void> uploadProfileImage(
    {required String profileId, required File image}) async {
  String? accessToken = await getAccessToken();
  final url = Endpoints.profilePhotoUplaod(profileId);
  var postUri = Uri.parse(url);
  var request = http.MultipartRequest("PUT", postUri);
  request.headers.addAll({
    'Authorization': 'Bearer $accessToken',
  });
  request.files.add(
    await http.MultipartFile.fromPath(
      'file',
      image.path,
    ),
  );

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      print('Successfully Uploaded Image...');
    } else {
      throw Exception('Failed to upload image');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('Failed to upload image');
  }
}

Future<void> deleteProfileImage({required String profileId}) async {
  String? accessToken = await getAccessToken();
  final url = Endpoints.profilePhotoUplaod(profileId);
  try {
    final http.Response response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      print('Successfully Deleted Image...');
    } else {
      throw Exception('Failed to delete image');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('Failed to delete image');
  }
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
