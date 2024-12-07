import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_flutter3/Model/Laporan.dart';
import 'package:location/location.dart';
import 'package:mobile_flutter3/services/location_services.dart';
import 'package:mobile_flutter3/services/user_services.dart';


class LaporanService {
  static const String _baseUrl = 'https://amanin.my.id/api/laporan';
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Location _location = Location();

  Future<List<Laporan>> fetchLaporan() async {
    final token = await storage.read(key: 'auth_token');

    if (token == null) {
      print('No auth token found.');
      throw Exception('Authentication token not found');
    }

    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

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

  Future<void> createLaporanWithLocation({
    required String location,
    required String desc,
    required String jenisKriminalitas,
    required File imageFile, // Tambahkan parameter file
  }) async {
    final token = await storage.read(key: 'auth_token');

    if (token == null) {
      throw Exception('Authentication token not found');
    }

    try {
      // Ambil lokasi pengguna saat ini
      final LocationService locationService = LocationService();
      final LocationData currentLocation = await locationService.getCurrentLocation();

      final latitude = currentLocation.latitude?.toString() ?? '0.0';
      final longitude = currentLocation.longitude?.toString() ?? '0.0';

      // Ambil user data
      final UserServices userServices = UserServices();
      final user = await userServices.fetchUserData();

      if (user == null || user.id == null) {
        throw Exception('User data not found');
      }

      final userId = user.id;

      // Endpoint untuk membuat laporan
      final uri = Uri.parse('https://amanin.my.id/api/laporan/create');

      // Buat multipart request
      final request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        })
        ..fields['user_id'] = userId.toString()
        ..fields['lokasi_kejadian'] = location
        ..fields['description'] = desc
        ..fields['title'] = jenisKriminalitas
        ..fields['latitude'] = latitude
        ..fields['longitude'] = longitude
        ..fields['datetime'] = DateTime.now().toIso8601String()
        ..files.add(await http.MultipartFile.fromPath(
          'image', // Pastikan nama field sama dengan yang diminta backend
          imageFile.path,
        ));

      // Kirim request
      final response = await request.send();

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Laporan berhasil dibuat.');
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Failed to create laporan: $responseBody');
        throw Exception('Failed to create laporan: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating laporan: $e');
      throw Exception('Error creating laporan: $e');
    }
  }

}
