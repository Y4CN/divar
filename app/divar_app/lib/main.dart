import 'package:divar_app/pages/home/homeScreen.dart';
import 'package:divar_app/pages/splash/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('fa'),
      theme: ThemeData(
        fontFamily: "IranSans",
      ),
      // home: HomeScreen(),
      home: const SplashScreen(),
    );
  }
}
