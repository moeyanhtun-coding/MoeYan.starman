import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starman/views/passcode_view.dart';
import 'dart:async';
import '../views/starid_view.dart';

late SharedPreferences prefs;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    bool isExistStarId = await _validationStarId();
    Timer(
      Duration(seconds: 3),
      () {
        if (isExistStarId) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PasscodeView(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => StaridView(),
            ),
          );
        }
      },
    );
  }

  Future<bool> _validationStarId() async {
    final prefs = await SharedPreferences.getInstance();
    String? checkStarId = prefs.getString("_starId");
    return checkStarId != null ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Starman', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
