import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_flutter3/Model/Laporan.dart';
import 'package:mobile_flutter3/laporan/detail_other_laporan_screen.dart';
import 'package:mobile_flutter3/services/laporan_services.dart';
import 'package:mobile_flutter3/shared/style.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  List<Laporan> _laporan = [];
  final double radiusThreshold = 500.0;

  @override
  void initState() {
    super.initState();
    _initLocation();
    _fetchLaporan();
  }

  double _calculateDistance(LatLng point1, LatLng point2) {
    return Distance().as(LengthUnit.Meter, point1, point2);
  }

  Future<void> _fetchLaporan() async {
    try {
      final laporanService = LaporanService();
      final laporanList = await laporanService.fetchLaporan();
      setState(() {
        _laporan = laporanList;
      });
    } catch (e) {
      print('Error fetching laporan: $e');
    }
  }

  Future<void> _initLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      log(_locationData.toString());
      mapController.move(LatLng(_locationData?.latitude ?? 0, _locationData?.longitude ?? 0), 16);
    });
  }

  LatLng _calculateCenter(List<Laporan> nearbyReports) {
    double latSum = 0.0;
    double lonSum = 0.0;

    for (var laporan in nearbyReports) {
      latSum += double.tryParse(laporan.latitude) ?? 0.0;
      lonSum += double.tryParse(laporan.longitude) ?? 0.0;
    }

    return LatLng(latSum / nearbyReports.length, lonSum / nearbyReports.length);
  }

  double _calculateMaxDistance(LatLng center, List<Laporan> nearbyReports) {
    double maxDistance = 0.0;

    for (var laporan in nearbyReports) {
      LatLng laporanLocation = LatLng(
        double.tryParse(laporan.latitude) ?? 0.0,
        double.tryParse(laporan.longitude) ?? 0.0,
      );
      double distance = _calculateDistance(center, laporanLocation);
      if (distance > maxDistance) {
        maxDistance = distance;
      }
    }

    return maxDistance;
  }

  Color _getCircleColor(int nearbyReportsCount) {
    if (nearbyReportsCount >= 10) {
      return Colors.red.withOpacity(0.4);
    } else if (nearbyReportsCount >= 6) {
      return Colors.orange.withOpacity(0.4);
    } else if (nearbyReportsCount >= 3) {
      return Colors.yellow.withOpacity(0.4);
    } else {
      return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FlutterMap(
        mapController: mapController,
        options: const MapOptions(
          initialZoom: 5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),

          if (_laporan.isNotEmpty)
            CircleLayer(
              circles: _laporan.map((laporan) {
                LatLng laporanLocation = LatLng(
                    double.tryParse(laporan.latitude) ?? 0.0,
                    double.tryParse(laporan.longitude) ?? 0.0);

                List<Laporan> nearbyReports = _laporan.where((otherLaporan) {
                  LatLng otherLocation = LatLng(
                      double.tryParse(otherLaporan.latitude) ?? 0.0,
                      double.tryParse(otherLaporan.longitude) ?? 0.0);
                  double distance = _calculateDistance(laporanLocation, otherLocation);
                  return distance <= radiusThreshold; // Jika dalam radiusThreshold
                }).toList();

                log("Nearby Reports: ${nearbyReports.length}");

                if (nearbyReports.length >= 3) {
                  LatLng center = _calculateCenter(nearbyReports);
                  double maxDistance = _calculateMaxDistance(center, nearbyReports);

                  Color circleColor = _getCircleColor(nearbyReports.length);

                  return CircleMarker(
                    point: center,
                    radius: 20,
                    color: circleColor,
                    borderStrokeWidth: 2.0,
                    borderColor: Colors.blue,
                    useRadiusInMeter: true,
                  );
                }
                return null;
              }).whereType<CircleMarker>().toList(),
            ),

          MarkerLayer(
            markers: _laporan.map((laporan) {
              LatLng laporanLocation = LatLng(
                  double.tryParse(laporan.latitude) ?? 0.0,
                  double.tryParse(laporan.longitude) ?? 0.0);

              List<Laporan> nearbyReports = _laporan.where((otherLaporan) {
                LatLng otherLocation = LatLng(
                    double.tryParse(otherLaporan.latitude) ?? 0.0,
                    double.tryParse(otherLaporan.longitude) ?? 0.0);
                double distance = _calculateDistance(laporanLocation, otherLocation);
                return distance <= radiusThreshold; // Jika dalam radiusThreshold
              }).toList();

              // Log nearbyReports count for debugging
              log("Nearby Reports: ${nearbyReports.length}");

              if (nearbyReports.length > 3) {
                return Marker(
                  width: 200.w,
                  height: 90.h,
                  point: LatLng(
                    double.tryParse(laporan.latitude) ?? 0.0, // Konversi ke double
                    double.tryParse(laporan.longitude) ?? 0.0, // Konversi ke double
                  ),
                  child: GestureDetector(
                    onTap: (){
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.scale,
                        titleTextStyle: appBar,
                        descTextStyle: detailValue,
                        buttonsTextStyle: whiteOnBtn,
                        title: laporan.title,
                        desc: laporan.datetime,
                        btnCancelOnPress: () {
                          print('Kembali');
                        },
                        btnOkOnPress: () async {
                          try {
                            final laporanDetail = await LaporanService().fetchLaporanByIdLocally(laporan.id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailOtherLaporanScreen(laporan: laporanDetail),
                              ),
                            );
                          } catch (e) {
                            print('Error fetching laporan by ID: $e');
                          }
                        },

                        btnOkColor: Colors.red,
                        btnCancelColor: Colors.grey,
                        btnOkText: 'Lihat Detail',
                        btnCancelText: 'Kembali',
                      ).show();
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Icon Marker
                        const Icon(Icons.warning, color: Colors.red, size: 40),
                        Positioned(
                          top: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              laporan.title,
                              style: whiteLabel,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Marker(
                  width: 80,
                  height: 80,
                  point: laporanLocation,
                  child: Icon(Icons.warning, color: Colors.orange, size: 40),
                );
              }
            }).toList(),
          ),

          if (_locationData != null)
            MarkerLayer(
              markers: [
                Marker(
                  width: 80,
                  height: 80,
                  point: LatLng(
                      _locationData!.latitude!, _locationData!.longitude!),
                  child: Icon(Icons.location_history, color: Colors.blueAccent, size: 40),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.zero,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: Colors.white,
          mini: true,
          child: Center(child: Icon(Icons.arrow_back_ios, color: Colors.black)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
