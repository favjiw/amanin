import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter3/Model/Laporan.dart';
import 'package:mobile_flutter3/generated/assets.dart';
import 'package:mobile_flutter3/history/LaporanImageWidget.dart';
import 'package:mobile_flutter3/services/laporan_services.dart';
import 'package:mobile_flutter3/shared/style.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});


  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin{
  late Future<List<Laporan>> _futureLaporan;
  final LaporanService _laporanService = LaporanService();
  late TabController tabController;
  int tabIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    _futureLaporan = _laporanService.fetchLaporan();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }
  //
  // Future<String> getImageUrl(String laporanId) async {
  //   try {
  //     final imageUrl = await LaporanService().fetchImage(laporanId);
  //     print("THIS IS IMAGE URL: ${imageUrl}");
  //     return imageUrl;
  //   } catch (e) {
  //     print('Error fetching image URL: $e');
  //     return '';
  //   }
  // }


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
              Tab(
                child: Text("Diajukan"),
              ),
              Tab(
                child: Text("Diproses"),
              ),
              Tab(
                child: Text("Selesai"),
              ),
            ],
          ),
        ),
      body: TabBarView(
        controller: tabController,
        physics: BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        children: [
          SingleChildScrollView(
            child: SizedBox(
              width: 1.sw,
              height: 1000.h,
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

                    final laporanList = snapshot.data!;
                    return ListView.builder(
                      itemCount: laporanList.length,
                      itemBuilder: (context, index) {
                        final laporan = laporanList[index];
                        return ListTile(
                          leading: SizedBox(
                            width: 60,
                            height: 60,
                            child: LaporanImageWidget(laporanId: laporan.id.toString()),
                          ),
                          title: Text(laporan.title ?? 'No Title'),
                          subtitle: Text(laporan.desc ?? 'No Description'),
                        );
                      },
                    );

                  },
                ),
                // child: FutureBuilder<List<Laporan>>(
                //     future: _futureLaporan,
                //     builder: (context, snapshot){
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return const Center(child: CircularProgressIndicator());
                //       } else if (snapshot.hasError) {
                //         return Center(child: Text('Error: ${snapshot.error}'));
                //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                //         return const Center(child: Text('Tidak ada laporan.'));
                //       }
                //       final laporanList = snapshot.data!;
                //       return ListView.builder(
                //         physics: const NeverScrollableScrollPhysics(),
                //         padding: EdgeInsets.zero,
                //         shrinkWrap: true,
                //         itemCount: laporanList.length,
                //         itemBuilder: (context, index){
                //           final laporan = laporanList[index];
                //           return Column(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               SizedBox(height: 20.h,),
                //               Container(
                //                 width: 318.w,
                //                 decoration: BoxDecoration(
                //                   color: HexColor('#D9D9D9'),
                //                   borderRadius: BorderRadius.circular(12.r),
                //                 ),
                //                 child: Column(
                //                   children: [
                //                     SizedBox(height: 5.h,),
                //                     Text(laporan.title, style: detailLabel,),
                //                     SizedBox(height: 5.h,),
                //                     Image.network(
                //                       imageUrl,
                //                       width: 150,
                //                       height: 150,
                //                       fit: BoxFit.cover,
                //                       errorBuilder: (context, error, stackTrace) {
                //                         print("ERROR image: ${error}");
                //                         print("statckTrace image: ${stackTrace}");
                //                         return Icon(Icons.broken_image, size: 50);
                //                       },
                //                     ),
                //                     SizedBox(height: 5.h,),
                //                     Row(
                //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Row(
                //                           crossAxisAlignment: CrossAxisAlignment.center,
                //                           children: [
                //                             SizedBox(width: 8.h,),
                //                             Image.asset(Assets.assetsCalendarIc, width: 24.w, height: 24.h,),
                //                             SizedBox(width: 10.h,),
                //                             Text(laporan.datetime, style: historyDate,),
                //                           ],
                //                         ),
                //                         Row(
                //                           children: [
                //                             SizedBox(
                //                               width: 90.w,
                //                               height: 40.h,
                //                               child: ElevatedButton(
                //                                 onPressed: () {
                //                                   Navigator.pushNamed(context, '/detailLaporan');
                //                                   print('Full image URL: ${laporan.image}');
                //                                 },
                //                                 style: ElevatedButton.styleFrom(
                //                                   backgroundColor: mainColor, // Set background color to mainColor
                //                                   shape: RoundedRectangleBorder(
                //                                     borderRadius: BorderRadius.circular(7.0), // Set border radius to 7
                //                                   ),
                //                                 ),
                //                                 child: Text('Lihat', style: historyOnBtn,), // Your button text
                //                               ),
                //                             ),
                //                             SizedBox(width: 13.w,),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                     SizedBox(height: 8.h,),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           );
                //         },
                //       );
                //     }
                // ),
              ),
            ),
          ),
          Text('Diproses'),
          Text('Selesai'),
        ],
      ),
    );
  }
}
