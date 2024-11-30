import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_flutter3/shared/style.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
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
                  Text(
                    'Welcome, Karina',
                    style: homeWelcome,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/notif-none-ic.png',
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
                      onPressed: () {},
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
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index){
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
                                  Text('Pencurian'),
                                  SizedBox(height: 2.h,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/location-ic.png', width: 15.w, height: 17.h,),
                                      SizedBox(width: 3.w,),
                                      Text('Kiaracondong'),
                                    ],
                                  ),
                                ],
                              ),
                              Text('03:00'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,)
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
