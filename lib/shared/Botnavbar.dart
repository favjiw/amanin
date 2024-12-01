import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_flutter3/history/HistoryScreen.dart';
import 'package:mobile_flutter3/home/HomeScreen.dart';
import 'package:mobile_flutter3/profile/ProfileScreen.dart';
import 'package:mobile_flutter3/splash/splash_screen.dart';
import 'package:mobile_flutter3/stats/StatScreen.dart';

class Botnavbar extends StatefulWidget {
  const Botnavbar({super.key});

  @override
  State<Botnavbar> createState() => _BotnavbarState();
}

class _BotnavbarState extends State<Botnavbar> {
  int currentIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Homescreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        shape: CircleBorder(),
        child: Text('SOS'),
        // child: Image.asset(
        //   'assets/home-ic.png',
        //   width: 40.w,
        //   height: 40.h,
        // ),
        onPressed: () {
          // Navigator.pushNamed(context, '/complaint');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 88.12.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 5.w,),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Homescreen();
                        currentIndex = 0;
                      });
                    },
                    icon: Image.asset(
                      currentIndex == 0
                          ? 'assets/home-ic.png'
                          : 'assets/home-inactive-ic.png',
                      width: 25.52.w,
                      height: 26.06.h,
                    ),
                  ),
                  SizedBox(width: 20.w,),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = StatScreen();
                        currentIndex = 1;
                      });
                    },
                    icon: Image.asset(
                      currentIndex == 1
                          ? 'assets/stats-ic.png'
                          : 'assets/stats-inactive-ic.png', width: 25.52.w, height: 26.06.h,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = HistoryScreen();
                        currentIndex = 2;
                      });
                    },
                    icon: Image.asset(
                      currentIndex == 2
                          ? 'assets/history-ic.png'
                          : 'assets/history-inactive-ic.png', width: 25.52.w, height: 26.06.h,
                    ),
                  ),
                  SizedBox(width: 20.w,),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfileScreen();
                        currentIndex = 3;
                      });
                    },
                    icon: Image.asset(
                      currentIndex == 3
                          ? 'assets/profile-ic.png'
                          : 'assets/profile-inactive-ic.png', width: 25.52.w, height: 26.06.h,
                    ),
                  ),
                  SizedBox(width: 5.w,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
