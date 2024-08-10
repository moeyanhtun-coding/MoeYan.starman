import 'package:flutter/material.dart';
import 'dart:async';
import '../views/starid_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          //TODO:Existing user state check in share preferences
          //TODO:

          //New User state
          MaterialPageRoute(builder: (context) => StaridView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9087F0),
      body: Center(
          child: Image.asset(
        'assets/sslogo.png',
        width: 250,
        height: 250,
      )),
    );
  }
}
