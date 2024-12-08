import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ReportServices {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> createReport({
    required int laporanId,
    required int userId,
    required String description,
  }) async {
    final token = await storage.read(key: 'auth_token');

    if (token == null) {
      throw Exception('Authentication token not found');
    }

    try {
      // URL endpoint untuk membuat laporan
      final uri = Uri.parse('https://amanin.my.id/api/reports/create');
      final String date = DateTime.now().toIso8601String();

      // Membuat request body
      final body = {
        'laporan_id': laporanId.toString(),
        'user_id': userId.toString(),
        'description': description,
        'datetime': date,
      };

      // Kirim request menggunakan POST
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Laporan berhasil dibuat');
      } else {
        print('Gagal membuat laporan: ${response.body}');
        throw Exception('Gagal membuat laporan: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
      throw Exception('Error creating report: $e');
    }
  }
}
