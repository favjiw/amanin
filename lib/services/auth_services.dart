import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_flutter3/Model/User.dart';

class AuthService {
  final String _baseUrl = "https://amanin.my.id/api";

  Future<void> storeToken(String token) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'auth_token', value: token);
  }

  Future<void> storeUserId(String userId) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'user_id', value: userId);
  }

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse("$_baseUrl/register");
    final String currentTime = DateTime.now().toIso8601String();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': '-',
          'username': username,
          'email': email,
          'email_verified_at': null,
          'password': password,
          'role': 'user',
          'remember_token': null,
          'created_at': currentTime,
          'updated_at': 'user',
        }),
      );

      if (response.statusCode == 200) {
        // Jika berhasil, decode JSON response dan kembalikan data
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data};
      } else {
        // Jika gagal, kembalikan pesan error dari response
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'message': error['message'] ?? 'Registration failed'
        };
      }
    } catch (e) {
      // Tangani jika ada exception
      return {'success': false, 'message': 'Something went wrong: $e'};
    }
  }

  Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('https://amanin.my.id/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print('Raw API response: ${response.body}');

      if (response.statusCode == 200) {
        final body = response.body;

        if (body.startsWith('{')) {
          // Jika respons berupa JSON
          final data = jsonDecode(body);
          // print('Decoded API response: $data');

          if (data['success'] ?? false) {
            final token = data['token'];
            await storeToken(token);

            // Parsing data user jika tersedia
            if (data.containsKey('data')) {
              try {
                final user = User.fromJson(data);
                print('User logged in: ${user.name}');
                return {'success': true, 'user': user};
              } catch (e) {
                print('Error parsing user: $e');
                return {'success': false, 'message': 'Failed to parse user data'};
              }
            }

            return {'success': true, 'message': 'Login successful, token saved'};
          } else {
            return {'success': false, 'message': data['message']};
          }
        } else {
          // Jika respons hanya berupa token string
          await storeToken(body); // Simpan token langsung
          print('Token stored: $body');
          return {'success': true, 'message': 'Token saved'};
        }
      } else {
        return {
          'success': false,
          'message': 'Login failed: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  Future<void> logout(String token) async {
    try {
      final response = await http.get(
        Uri.parse('https://amanin.my.id/api/logout'),
        headers: {
          'Content-Type': 'application/json',
          // Jika ada token yang perlu dikirim, bisa masukkan header Authorization
          'Authorization': 'Bearer $token',
        },
      );

      print("Error Response: ${response.body}");

      if (response.statusCode == 200) {
        // Proses logout berhasil
        print("Logout berhasil!");
        return;
      } else {
        // Jika ada masalah saat logout
        print("Logout gagal: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan saat logout: $e");
    }
  }
}
