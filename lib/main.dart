import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starman/views/starid_view.dart';
import 'package:starman/views/passcode_view.dart';

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
        //home: PasscodeView(),
        home: RegisterView(),

    );
  }
}
