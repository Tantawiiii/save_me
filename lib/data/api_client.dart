// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  static Future<String?> loginUser(String email, String password) async {
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
      await prefs.setString('access_token', responseData['access_token']);
      final user = await getUserProfileData();
      if (user != null) {
        prefs.setString('user', jsonEncode(user.toJson()));
      }
      return "Login Successful!";
    } else {
      if (kDebugMode) {
        print("Error: ${response.statusCode}");
        print("Error Body: ${response.body}");
      }
      return null;
    }
  }

  static Future<User?> getUserProfileData() async {
    String? accessToken = await getAccessToken();
    const url = Endpoints.register;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return User.fromJson(responseData);
      } else {
        return null;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "$error");
      throw Exception('Failed to load user profile data');
    }
  }

  Future<User?> updateUserProfile(User user) async {
    const url = Endpoints.register;
    String? accessToken = await getAccessToken();
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        // Store the user data token using shared_preferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(responseData));
        return user;
      } else {
        if (kDebugMode) {
          print("Error: ${response.statusCode}");
          print("Error Body: ${response.body}");
        }
        return null;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "$error");
      throw Exception('Failed to update user profile. Status code');
    }
  }

  static Future<String?> changePassword(
      String oldPassword, String newPassword) async {
    String? accessToken = await getAccessToken();
    const url = Endpoints.changePassword;

    final body =
        jsonEncode({'oldPassword': oldPassword, 'newPassword': newPassword});

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Accept': '*/*'
    };

    final response = await http.patch(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    var responseDecoded = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "Password changed successfully";
    } else {
      return null;
    }
  }

  //upload image to user
  Future<void> uploadUserImage({required File image}) async {
    String? accessToken = await getAccessToken();
    const url = Endpoints.profileUserUplaodImage;
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
      log(response.statusCode.toString(), name: 'response');
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Successfully Uploaded Image...');
        }
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (error) {
      throw Exception('Failed to upload image');
    }
  }

  Future<void> uploadAvatar(List<Map<String, String>> idList) async {
    String? accessToken = await getAccessToken();
    const url = Endpoints.avatars;

    try {
      // Create a comma-separated string of IDs
      final idsString = idList.map((idMap) => idMap['id']).join(',');

      final response = await http.get(
        Uri.parse('$url?ids=$idsString'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        for (var item in data) {
          String photoUrl = item["photoUrl"];
          print(photoUrl);
        }
      } else {
        print('Failed to fetch photoUrls. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
}
