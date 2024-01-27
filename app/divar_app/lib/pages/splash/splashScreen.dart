import 'package:divar_app/const.dart';
import 'package:divar_app/pages/home/homeScreen.dart';
import 'package:divar_app/pages/main/mainScreen.dart';
import 'package:divar_app/pages/login/view.dart';
import 'package:divar_app/pages/register/view.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const RegisterPage();
          },
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Image.asset(
            "assets/images/DivarLogo.png",
            height: 30.h,
          ),
          WidgetConstant.loadingAnimation(10.w),
        ],
      ),
    );
  }
}
