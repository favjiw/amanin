import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_flutter3/generated/assets.dart';
import 'package:mobile_flutter3/shared/style.dart';

class DetailLaporanScreen extends StatefulWidget {
  const DetailLaporanScreen({super.key});

  @override
  State<DetailLaporanScreen> createState() => _DetailLaporanScreenState();
}

class _DetailLaporanScreenState extends State<DetailLaporanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Detail Laporan',
        ),
        titleTextStyle: appBar,
        actions: [
          IconButton(
            icon: Icon(
              Icons.close_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/botnavbar');
            },
          ),
        ],
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
                      Text('Konvoi Berbahaya', style: detailTitle, textAlign: TextAlign.center,),
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
                      boxShadow: [

                      ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tanggal Laporan:', style: detailLabel,),
                          Text('Diproses', style: detailStatus,),
                        ],
                      ),
                      Text('11 Mei 2024', style: detailValue,),
                      SizedBox(height: 20.h,),
                      Text('Lokasi Kejadian:', style: detailLabel,),
                      Text('Jl. Manado', style: detailValue,),
                      SizedBox(height: 20.h,),
                      Text('Deskripsi:', style: detailLabel,),
                      Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent id enim consequat, pulvinar leo vel, porta lectus. Morbi tortor ipsum, commodo sed libero tincidunt, aliquam euismod ex. Etiam vitae ligula interdum, fringilla nulla vitae, feugiat velit. Morbi sagittis ex non massa luctus pretium. Curabitur non mi finibus, feugiat felis eget, condimentum felis. Nulla dictum aliquet turpis ut sodales. Etiam volutpat arcu eget ipsum rutrum, sed facilisis lorem sollicitudin. Nunc sagittis facilisis varius. Vestibulum non nisl quis tellus facilisis tristique. Nam gravida sem in nisl imperdiet, et laoreet mauris venenatis.', style: detailValue, textAlign: TextAlign.justify,),


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
