import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mobile_flutter3/Model/Laporan.dart';
import 'package:mobile_flutter3/generated/assets.dart';
import 'package:mobile_flutter3/services/laporan_services.dart';
import 'package:mobile_flutter3/shared/style.dart';

class LaporanAllScreen extends StatefulWidget {
  const LaporanAllScreen({super.key});

  @override
  State<LaporanAllScreen> createState() => _LaporanAllScreenState();
}

class _LaporanAllScreenState extends State<LaporanAllScreen> {
  late Future<List<Laporan>> _futureLaporan;
  final LaporanService _laporanService = LaporanService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureLaporan = _laporanService.fetchLaporan();
  }

  String formatTanggal(String rawDate) {
    DateTime date = DateTime.parse(rawDate);

    String formattedDate = DateFormat('d MMM yyyy').format(date);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Semua Laporan',
        ),
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
        titleTextStyle: appBar,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: FutureBuilder<List<Laporan>>(
              future: _futureLaporan,
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada laporan.'));
                }
                final laporanList = snapshot.data!;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: laporanList.length,
                  itemBuilder: (context, index){
                    final laporan = laporanList[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: (){},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                            width: 340.w,
                            height: 70.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: HexColor('#F5F5F8'),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 60.w,
                                      height: 60.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7.r),
                                        color: HexColor('#F79B6A'),
                                      ),
                                      child: Center(
                                        child: Image.asset(Assets.assetsWarningHomeImg, width: 60.w, height: 60.h,),
                                      ),
                                    ),
                                    SizedBox(width: 10.w,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(laporan.title, style: detailValue,),
                                        SizedBox(height: 2.h,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.location_on, color: Colors.black,),
                                            SizedBox(width: 3.w,),
                                            Text('${laporan.location}', style: detailValue,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  formatTanggal(laporan.datetime),
                                  style: detailValue,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,)
                      ],
                    );
                  },
                );
              }
          ),
        ),
      ),
    );
  }
}
