import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_flutter3/Model/User.dart';

class UserServices {
  final String _baseUrl = "https://amanin.my.id/api";
  final storage = FlutterSecureStorage();

  Future<User?> fetchUserData() async {
    // Retrieve stored token
    final token = await storage.read(key: 'auth_token');

    if (token == null) {
      print('No auth token found.');
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Decoded JSON data: $data');

        if (data['data'] != null && data['data']['id'] != null) {

          final userData = data['data'];
          return User.fromJson(userData);
        } else {
          print('This is from user_services: Invalid user data: missing or invalid id');
          return null;
        }
      } else {
        print('Error fetching user data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('This is from user_services: Error fetching user data: $e');
      return null;
    }
  }


  Future<List<User>> fetchUserWithoutToken() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/user'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((userJson) => User.fromJson(userJson)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }
}