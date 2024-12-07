import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<LocationData> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Cek apakah layanan lokasi diaktifkan
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw Exception("Location services are disabled.");
      }
    }

    // Periksa apakah izin lokasi telah diberikan
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception("Location permission denied.");
      }
    }

    // Ambil lokasi terkini
    return await _location.getLocation();
  }
}
