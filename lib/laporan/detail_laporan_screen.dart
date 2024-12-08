import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter3/Model/Laporan.dart';
import 'package:mobile_flutter3/shared/style.dart';
import 'package:intl/intl.dart';

class DetailLaporanScreen extends StatefulWidget {
  final Laporan laporan;

  const DetailLaporanScreen({super.key, required this.laporan});

  @override
  State<DetailLaporanScreen> createState() => _DetailLaporanScreenState();
}

class _DetailLaporanScreenState extends State<DetailLaporanScreen> {

  String formatTanggal(String rawDate) {
    DateTime date = DateTime.parse(rawDate);

    String formattedDate = DateFormat('d MMM yyyy').format(date);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final laporan = widget.laporan;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Detail Laporan',
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
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h,),
              Center(
                child: Container(
                  width: 301.w,
                  padding: EdgeInsets.only(bottom: 20.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ]
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          topRight: Radius.circular(15.r),
                        ),
                        child: Image.network('https://saibumi.id/wp-content/uploads/2024/10/Aksi-Berbahaya-13-Remaja-di-Klaten-Terlibat-Konvoi-dengan-Senjata.jpg', width: 301.w, height: 174.h, fit: BoxFit.cover,),
                      ),
                      SizedBox(height: 13.h),
                      Text(laporan.title, style: detailTitle, textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 55.h,),
              Center(
                child: Container(
                  width: 337.w,
                  padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 14.h),
                  decoration: BoxDecoration(
                      color: HexColor('#EAEAEA'),
                      borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tanggal Laporan:', style: detailLabel,),
                          Text(laporan.status, style: detailStatus,),
                        ],
                      ),
                      Text( formatTanggal(laporan.datetime), style: detailValue,),
                      SizedBox(height: 20.h,),
                      Text('Lokasi Kejadian:', style: detailLabel,),
                      Text(laporan.location, style: detailValue,),
                      SizedBox(height: 20.h,),
                      Text('Deskripsi:', style: detailLabel,),
                      Text(laporan.desc, style: detailValue, textAlign: TextAlign.justify,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h,),
            ],
          ),
        ),
      ),
    );
  }
}
