import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:starman/views/home_view.dart';
import 'package:starman/views/starid_view.dart';
import 'package:starman/views/passcode_view.dart';
import 'package:starman/views/splashscreen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/starId', page: () => StaridView()),
    GetPage(name: '/passcode', page: () => PasscodeView()),
    GetPage(name: '/homeView', page: () => HomeView()),
  ];
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);

    return GetMaterialApp(
      getPages: routes,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      //home: HomeView(),
      //home: PasscodeView(),
    );
  }
}
