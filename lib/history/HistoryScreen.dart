import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter3/generated/assets.dart';
import 'package:mobile_flutter3/shared/style.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});


  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin{
  late TabController tabController;
  int tabIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 36.w),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h,),
                      Container(
                        width: 318.w,
                        decoration: BoxDecoration(
                          color: HexColor('#D9D9D9'),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 5.h,),
                            Text('Pencurian Motor', style: detailLabel,),
                            SizedBox(height: 5.h,),
                            Image.network('https://saibumi.id/wp-content/uploads/2024/10/Aksi-Berbahaya-13-Remaja-di-Klaten-Terlibat-Konvoi-dengan-Senjata.jpg', width: 318.w, height: 148.h, fit: BoxFit.cover,),
                            SizedBox(height: 5.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 8.h,),
                                    Image.asset(Assets.assetsCalendarIc, width: 24.w, height: 24.h,),
                                    SizedBox(width: 10.h,),
                                    Text('10 Mei 2024', style: historyDate,),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 90.w,
                                      height: 40.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Handle button press
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: mainColor, // Set background color to mainColor
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(7.0), // Set border radius to 7
                                          ),
                                        ),
                                        child: Text('Lihat', style: historyOnBtn,), // Your button text
                                      ),
                                    ),
                                    SizedBox(width: 13.w,),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h,),
                          ],
                        ),
                      ),
                    ],
                  );
                }
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
