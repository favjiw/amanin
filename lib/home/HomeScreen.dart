import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mobile_flutter3/Model/Laporan.dart';
import 'package:mobile_flutter3/Model/User.dart';
import 'package:mobile_flutter3/generated/assets.dart';
import 'package:mobile_flutter3/home/UserListPage.dart';
import 'package:mobile_flutter3/notification/notification_screen.dart';
import 'package:mobile_flutter3/services/laporan_services.dart';
import 'package:mobile_flutter3/services/user_services.dart';
import 'package:mobile_flutter3/shared/style.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<List<Laporan>> _futureLaporan;
  final LaporanService _laporanService = LaporanService();
  User? _user;
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureLaporan = _laporanService.fetchLaporan();
    _fetchUserData();
    _initLocation();
  }

  Future<void> _initLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print("Lokasi tidak tersedia");
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print("Permission Denied");
        return;
      }
    }

    _locationData = await location.getLocation();

    // Log untuk mengecek nilai latitude dan longitude
    print("Latitude: ${_locationData?.latitude}");
    print("Longitude: ${_locationData?.longitude}");

    if (_locationData?.latitude == null || _locationData?.longitude == null) {
      print("Lokasi tidak valid");
    }
  }

  String formatTanggal(String rawDate) {
    DateTime date = DateTime.parse(rawDate);

    String formattedDate = DateFormat('d MMM yyyy').format(date);

    return formattedDate;
  }


  Future<void> shareLocationToWhatsApp() async {
    if (_locationData != null && _locationData!.latitude != null && _locationData!.longitude != null) {
      final double latitude = _locationData!.latitude!;
      final double longitude = _locationData!.longitude!;

      final String locationUrl = 'whatsapp://send?text=Lokasi%20Saya:%20https://www.google.com/maps?q=$latitude,$longitude';
      final Uri uri = Uri.parse(locationUrl);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        final String fallbackUrl = 'https://wa.me/?text=Lokasi%20Saya:%20https://www.google.com/maps?q=$latitude,$longitude';
        await launch(fallbackUrl);
        print('WhatsApp tidak ditemukan di perangkat atau tidak dapat membuka URL');
        throw 'Tidak dapat membuka WhatsApp';
      }
    } else {
      print('Lokasi tidak ditemukan atau tidak valid');
    }
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
      backgroundColor: Colors.white,
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
                  ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 130.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7.r),
                      ),
                    ),
                  )
                      :
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Welcome, ${_user!.username}',
                      style: homeWelcome,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(user: _user!), // Passing user model
                          ),
                        );
                      },
                      child: Image.asset(
                        Assets.assetsNotifNoneIc,
                        width: 31.34.w,
                        height: 28.h,
                      ),),
                ],
              ),
              SizedBox(height: 20.h,),
              Center(
                child: Container(
                  width: 350.w,
                  decoration: BoxDecoration(
                    color: HexColor('#1B4552'),
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: AssetImage(Assets.assetsHomeBgImg),
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 52.h, left: 15.w, right: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ayo Lapor!",
                          style: homeContainerTitle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Mari kita bangun\nIndonesia\nmenjadi lebih baik\ndengan\nmelaporkan\nkriminalitas!",
                              style: homeContainerSubtitle,
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Image.asset(
                                  Assets.assetsWomanImg,
                                  width: 160.w,
                                  height: 174.h,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: SizedBox(
                    width: 315.w,
                    height: 58.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                          backgroundColor: mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r)
                          )
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/createLaporan");
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50.w,
                            height: 50.h,
                          ),
                          Text('BUAT LAPORAN', style: whiteOnBtn,),
                          Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: Icon(Icons.add_rounded, color: Colors.white,),
                          ),
                        ],
                      ),
                    ),
                  ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/maps");
                          // print(currentId);
                        },
                        child: Container(
                          width: 166.w,
                          padding: EdgeInsets.only(top: 13.h, bottom: 13.h),
                          decoration: BoxDecoration(
                            color: HexColor('#F5F5F8'),
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 140.w,
                                height: 130.h,
                                decoration: BoxDecoration(
                                  color: HexColor('#DAC3EF'),
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                child: Center(
                                  child: Image.asset(Assets.assetsMapHomeImg, width: 100.w, height: 100.h,),
                                ),
                              ),
                              SizedBox(height: 5.h,),
                              Text('Maps Kriminalitas', style: homeFeatureTitle,),
                              SizedBox(height: 5.h,),
                            ],
                          ),
                        ),
                  ),
                  InkWell(
                        onTap: () {
                          shareLocationToWhatsApp();
                        },
                        child: Container(
                          width: 166.w,
                          padding: EdgeInsets.only(top: 13.h, bottom: 13.h),
                          decoration: BoxDecoration(
                            color: HexColor('#F5F5F8'),
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 140.w,
                                height: 130.h,
                                decoration: BoxDecoration(
                                  color: HexColor('#F7D047'),
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                child: Center(
                                  child: Image.asset(Assets.assetsLocationHomeImg, width: 100.w, height: 100.h,),
                                ),
                              ),
                              SizedBox(height: 5.h,),
                              Text('Share Location', style: homeFeatureTitle,),
                              SizedBox(height: 5.h,),
                            ],
                          ),
                        ),
                      ),
                    ],
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Laporan Terbaru', style: homeTitle,),
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/laporanAll');
                      },
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
                      itemCount: 3,
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
            ],
          ),
        ),
      ),
    );
  }
}
