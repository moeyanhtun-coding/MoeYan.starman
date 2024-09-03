import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starman/views/error_view.dart';
import 'package:starman/views/existing_passcode_view.dart';
import 'package:get/route_manager.dart';
import 'package:starman/views/home_view.dart';
import 'package:starman/views/new_error_view.dart';
import 'package:starman/views/report_view/cf_report_view.dart';
import 'package:starman/views/report_view/profitlost_report_view.dart';
import 'package:starman/views/starid_view.dart';
import 'package:starman/views/passcode_view.dart';
import 'package:starman/views/splashscreen.dart';
import 'package:starman/views/report_view/cf_daily_report_view.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFA39FD9);
  static const Color secondaryColor = Color(0xFFA6A6A6);
}

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/starId', page: () => StaridView()),
    GetPage(name: '/passcode', page: () => PasscodeView()),
    GetPage(name: '/home', page: () => HomeView()),
    GetPage(name: '/error', page: () => ErrorView()),
    GetPage(name: '/existingPasscode', page: () => ExistingPasscodeView()),
    GetPage(name: '/profitlost', page: () => ProfitLostReportView()),
    GetPage(name: '/cfreport', page: () => CfReportView()),
    GetPage(name: '/cashflowdaily', page: () => CfDailyReportView())
  ];

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);

    return GetMaterialApp(
      getPages: routes,
      debugShowCheckedModeBanner: false,
      home: CfDailyReportView(),
    );
  }
}
