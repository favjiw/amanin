import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_flutter3/auth/login_screen.dart';
import 'package:mobile_flutter3/auth/signup_screen.dart';
import 'package:mobile_flutter3/history/HistoryScreen.dart';
import 'package:mobile_flutter3/home/HomeScreen.dart';
import 'package:mobile_flutter3/laporan/create_laporan_screen.dart';
import 'package:mobile_flutter3/laporan/detail_laporan_screen.dart';
import 'package:mobile_flutter3/laporan/laporan_all_screen.dart';
import 'package:mobile_flutter3/maps/maps_screen.dart';
import 'package:mobile_flutter3/notification/notification_screen.dart';
import 'package:mobile_flutter3/profile/ProfileScreen.dart';
import 'package:mobile_flutter3/shared/Botnavbar.dart';
import 'package:mobile_flutter3/splash/splash_screen.dart';
import 'package:mobile_flutter3/stats/StatScreen.dart';

void main() {
  runApp(const MainApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatefulWidget {

  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 812),
      builder: (context, child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          initialRoute: '/splash',
          routes: <String, WidgetBuilder>{
            '/splash': (context) => SplashScreen(),
            '/botnavbar': (context) => Botnavbar(),
            '/login': (context) => LoginScreen(),
            '/signup': (context) => SignupScreen(),
            '/home': (context) => Homescreen(),
            '/stats': (context) => StatScreen(),
            '/history': (context) => HistoryScreen(),
            '/maps': (context) => MapScreen(),
            '/profile': (context) => ProfileScreen(),
            '/createLaporan': (context) => CreateLaporanScreen(),
            // '/detailLaporan': (context) => DetailLaporanScreen(),
            // '/notification': (context) => NotificationScreen(),
            '/laporanAll': (context) => LaporanAllScreen(),
          },
        );
      },
    );
  }
}


