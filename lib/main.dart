import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_flutter3/shared/Botnavbar.dart';
import 'package:mobile_flutter3/splash/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

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
          home: Botnavbar(),
        );
      },
    );
  }
}


