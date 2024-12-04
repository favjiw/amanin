import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_flutter3/history/HistoryScreen.dart';
import 'package:mobile_flutter3/home/HomeScreen.dart';
import 'package:mobile_flutter3/profile/ProfileScreen.dart';
import 'package:mobile_flutter3/shared/style.dart';
import 'package:mobile_flutter3/stats/StatScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Botnavbar extends StatefulWidget {
  const Botnavbar({super.key});

  @override
  State<Botnavbar> createState() => _BotnavbarState();
}

class _BotnavbarState extends State<Botnavbar> {
  final String _number = "082117778131";
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
        shape: const CircleBorder(),
        child: Text('SOS', style: sos,),
        onPressed: () {
          launchUrlString("tel://911");
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
