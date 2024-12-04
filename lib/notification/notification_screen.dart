import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter3/shared/style.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 20,
        itemBuilder: (context, index){
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
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Laporan berhasil dibuat', style: detailLabel,),
                    SizedBox(height: 5.h,),
                    Text('Konvoi Berbahaya', style: detailStatus,),
                    SizedBox(height: 5.h,),
                    Text('04-12-2024', style: detailValue,)
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
            ],
          );
        },
      ),
    );
  }
}
