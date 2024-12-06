import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter3/Model/Laporan.dart';
import 'package:mobile_flutter3/Model/User.dart';
import 'package:mobile_flutter3/generated/assets.dart';
import 'package:mobile_flutter3/home/UserListPage.dart';
import 'package:mobile_flutter3/services/laporan_services.dart';
import 'package:mobile_flutter3/services/user_services.dart';
import 'package:mobile_flutter3/shared/style.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<List<Laporan>> _futureLaporan;
  final LaporanService _laporanService = LaporanService();
  User? _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureLaporan = _laporanService.fetchLaporan();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = await UserServices().fetchUserData();
    setState(() {
      _user = user;
    });
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://amanin.my.id/api/user'));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _user == null
                  ? const CircularProgressIndicator()
                      :
                  Text(
                    'Welcome, ${_user!.username}',
                    style: homeWelcome,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/notification');
                      },
                      child: Image.asset(
                        Assets.assetsNotifNoneIc,
                        width: 31.34.w,
                        height: 28.h,
                      ),),
                ],
              ),
              SizedBox(height: 30.h,),
              Center(
                child: SizedBox(
                    width: 315.w,
                    height: 58.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r)
                          )
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/createLaporan");
                      },
                      child: Text(
                        "Buat Laporan",
                        style: whiteOnBtn,
                      ),
                    ),
                  ),
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/maps");
                          // print(currentId);
                        },
                        child: Container(
                          width: 166.w,
                          height: 166.h,
                          padding: EdgeInsets.only(top: 13.h, bottom: 13.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7.r),

                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 40.w,
                                height: 40.h,
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  shape: BoxShape.circle,
                                ),
                                // child: Image.asset(
                                //   "assets/ic-report.png",
                                //   width: 25.w,
                                //   height: 25.h,
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text('Maps Kriminalitas'),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Userlistpage()),
                          );
                          // Navigator.pushNamed(context, "/complaint");
                          // print(currentId);
                        },
                        child: Container(
                          width: 166.w,
                          height: 166.h,
                          padding: EdgeInsets.only(top: 13.h, bottom: 13.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7.r),
                      
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 40.w,
                                height: 40.h,
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  shape: BoxShape.circle,
                                ),
                                // child: Image.asset(
                                //   "assets/ic-report.png",
                                //   width: 25.w,
                                //   height: 25.h,
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text('Share Location'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Laporan Terbaru', style: homeTitle,),
                  TextButton(
                      onPressed: (){},
                      child: Text('See all', style: seeAll,))
                ],
              ),
              FutureBuilder<List<Laporan>>(
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
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(laporan.desc),
                                        SizedBox(height: 2.h,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/location-ic.png', width: 15.w, height: 17.h,),
                                            SizedBox(width: 3.w,),
                                            Text('${laporan.latitude}, ${laporan.longitude}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(laporan.datetime),
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
            ],
          ),
        ),
      ),
    );
  }
}
