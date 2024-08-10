import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starman/views/error_view.dart';
import 'package:starman/views/existing_passcode_view.dart';
import 'package:starman/views/home_view.dart';
import 'package:starman/views/new_error_view.dart';
import 'package:starman/views/starid_view.dart';
import 'package:starman/views/passcode_view.dart';
import 'package:starman/views/splashscreen.dart';


class AppColors{
  static const Color primaryColor = Color(0xFFA39FD9);
  static const Color secondaryColor = Color(0xFFA6A6A6);
}


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: SplashScreen(),
      home:PasscodeView(),
    );
  }
}