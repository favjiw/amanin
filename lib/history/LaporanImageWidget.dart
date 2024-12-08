import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LaporanImageWidget extends StatelessWidget {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final String laporanId;
  LaporanImageWidget({super.key, required this.laporanId});

  Future<String> fetchImageUrl(String laporanId) async {

    final token = await storage.read(key: 'auth_token');
    if (token == null) {
      throw Exception('Authentication token not found');
    }

    final uri = Uri.parse('https://amanin.my.id/api/laporan/image/$laporanId');

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return uri.toString(); // URL gambar valid
    } else {
      throw Exception('Failed to fetch image: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: fetchImageUrl(laporanId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return Image.network(
            snapshot.data!,
            headers: {
              'Authorization': 'Bearer ${storage.read(key: 'auth_token')}', // Autentikasi
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text('Gagal memuat gambar'),
              );
            },
          );
        } else {
          return const Center(child: Text('Tidak ada data'));
        }
      },
    );
  }
}

