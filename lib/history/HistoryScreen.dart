import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter3/Model/Laporan.dart';
import 'package:mobile_flutter3/Model/User.dart';
import 'package:mobile_flutter3/generated/assets.dart';
import 'package:mobile_flutter3/laporan/detail_laporan_screen.dart';
import 'package:mobile_flutter3/services/laporan_services.dart';
import 'package:mobile_flutter3/services/user_services.dart';
import 'package:mobile_flutter3/shared/style.dart';
import 'package:shimmer/shimmer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});


  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin{
  late Future<List<Laporan>> _futureLaporan;
  final LaporanService _laporanService = LaporanService();
  late TabController tabController;
  String? token;
  User? _user;
  int tabIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    _fetchUserData();
    loadToken();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = await UserServices().fetchUserData();
      setState(() {
        _user = user;
      });
      // Setelah _user terisi, fetch laporan
      _futureLaporan = _laporanService.fetchLaporanByUserId(_user!.id);
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> loadToken() async {
    final storage = FlutterSecureStorage();
    final fetchedToken = await storage.read(key: 'auth_token');
    if (fetchedToken != null) {
      setState(() {
        token = fetchedToken;
      });
    } else {
      // Token tidak ditemukan, lakukan sesuatu
    }
  }

  Future<String> getImageUrl(String laporanId) async {
    try {
      final imageUrl = await LaporanService().fetchImage(laporanId);
      print("THIS IS IMAGE URL: ${imageUrl}");
      return imageUrl;
    } catch (e) {
      print('Error fetching image URL: $e');
      return '';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Riwayat Laporan",
          style: appBarHistory,
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          labelStyle: tabTitle,
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          unselectedLabelStyle: unSelectedTabTitle,
          unselectedLabelColor: HexColor('#757575'),
          tabs: const [
            Tab(child: Text("Diajukan")),
            Tab(child: Text("Diproses")),
            Tab(child: Text("Selesai")),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: const BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        children: [
          // Tab "Diajukan" (Pending)
          buildLaporanList("pending"),
          // Tab "Diproses" (In Progress)
          buildLaporanList("diproses"),
          // Tab "Selesai" (Completed)
          buildLaporanList("selesai"),
        ],
      ),
    );
  }

  Widget buildLaporanImage(String laporanId) {
    if (token == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return FutureBuilder<String>(
      future: getImageUrl(laporanId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 318.w,
              height: 150.h,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          );
        } else if (snapshot.hasError || snapshot.data!.isEmpty) {
          return const Icon(Icons.broken_image, size: 50);
        } else {
          final imageUrl = snapshot.data!;
          return Image.network(
            imageUrl,
            width: 318.w,
            height: 150.h,
            fit: BoxFit.cover,
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 50);
            },
          );
        }
      },
    );
  }


  Widget buildLaporanList(String status) {
    if (_user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: SizedBox(
        width: 1.sw,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.w),
          child: FutureBuilder<List<Laporan>>(
            future: _futureLaporan,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Tidak ada laporan.'));
              }

              // Filter laporan berdasarkan status
              final laporanList = snapshot.data!
                  .where((laporan) => laporan.status.toLowerCase() == status.toLowerCase())
                  .toList();

              if (laporanList.isEmpty) {
                return const Center(child: Text('Tidak ada laporan dengan status ini.'));
              }

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: laporanList.length,
                itemBuilder: (context, index) {
                  final laporan = laporanList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      Container(
                        width: 318.w,
                        decoration: BoxDecoration(
                          color: HexColor('#D9D9D9'),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 5.h),
                            Text(laporan.title, style: detailLabel),
                            SizedBox(height: 5.h),
                            buildLaporanImage(laporan.id.toString()),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 8.h),
                                    Image.asset(Assets.assetsCalendarIc, width: 24.w, height: 24.h),
                                    SizedBox(width: 10.h),
                                    Text(laporan.datetime, style: historyDate),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 90.w,
                                      height: 40.h,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          try {
                                            final laporanDetail = await LaporanService().fetchLaporanByIdLocally(laporan.id);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DetailLaporanScreen(laporan: laporanDetail),
                                              ),
                                            );
                                          } catch (e) {
                                            print('Error fetching laporan by ID: $e');
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: mainColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(7.0),
                                          ),
                                        ),
                                        child: Text('Lihat', style: historyOnBtn),
                                      ),
                                    ),
                                    SizedBox(width: 13.w),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}


