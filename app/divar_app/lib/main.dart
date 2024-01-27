import 'package:divar_app/pages/dep_injection.dart';
import 'package:divar_app/pages/home/homeScreen.dart';
import 'package:divar_app/pages/login/view.dart';
import 'package:divar_app/pages/splash/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await initGetIt();
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
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'),
      ],
      locale: const Locale('fa'),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "IranSans",
      ),
      home: const SplashScreen(),
      // home: const LoginPage(),
    );
  }
}
