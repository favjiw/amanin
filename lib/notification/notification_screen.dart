import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter3/Model/Laporan.dart';
import 'package:mobile_flutter3/Model/User.dart';
import 'package:mobile_flutter3/services/laporan_services.dart';
import 'package:mobile_flutter3/services/user_services.dart';
import 'package:mobile_flutter3/shared/style.dart';

class NotificationScreen extends StatefulWidget {
  final User user;

  const NotificationScreen({super.key, required this.user});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  User? _user;
  bool isLoading = true;
  Future<List<Laporan>>? _futureLaporan;

  @override
  void initState() {
    super.initState();
    _futureLaporan = null;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = await UserServices().fetchUserData();
      setState(() {
        _user = user;
      });

      if (_user != null) {
        _fetchLaporanById(_user!.id);
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _fetchLaporanById(int userId) async {
    try {
      final laporan = await LaporanService().fetchLaporanByUserId(userId);
      setState(() {
        _futureLaporan = Future.value(laporan);
      });
    } catch (e) {
      print('Error fetching laporan by ID: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Notifikasi',
        ),
        titleTextStyle: appBar,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: HexColor('#000000'),
          ),
          onPressed: () {
            // Handle button press
            Navigator.pop(context);
          },
        ),
      ),
      body: _futureLaporan == null
          ? Center(child: CircularProgressIndicator())
      : FutureBuilder<List<Laporan>>(
        future: _futureLaporan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show loading if fetching
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada notifikasi')); // No reports
          } else {
            final laporanList = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: laporanList.length, // Use the length of the fetched data
              itemBuilder: (context, index) {
                final laporan = laporanList[index]; // Get individual laporan
                return Column(
                  children: [
                    Container(
                      width: 1.sw,
                      padding: EdgeInsets.symmetric(horizontal: 58.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black.withOpacity(0.14), width: 1.w),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Berhasil membuat laporan!", style: detailLabel), // Dynamic title
                          SizedBox(height: 5.h),
                          Text(laporan.title, style: detailStatus), // Dynamic status
                          SizedBox(height: 5.h),
                          Text(laporan.datetime, style: detailValue), // Dynamic date
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
