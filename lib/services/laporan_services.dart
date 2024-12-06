import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_flutter3/Model/Laporan.dart';

class LaporanService {
  static const String _baseUrl = 'https://amanin.my.id/api/laporan';

  Future<List<Laporan>> fetchLaporan() async {
    // Retrieve stored token
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'auth_token');

    if (token == null) {
      print('No auth token found.');
      throw Exception('Authentication token not found');
    }

    try {
      final response = await http.get(
        Uri.parse('https://amanin.my.id/api/laporan'),
        headers: {
          'Authorization': 'Bearer $token',  // Add the token to the request headers
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Decode JSON response
        final Map<String, dynamic> json = jsonDecode(response.body);

        // Access the 'data' key, which contains the list of laporan
        if (json['data'] != null) {
          final List<dynamic> data = json['data'];
          return data.map((item) => Laporan.fromMap(item)).toList();
        } else {
          throw Exception('Data key not found in response');
        }
      } else {
        throw Exception('Failed to load laporan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching laporan: $e');
    }
  }


}
