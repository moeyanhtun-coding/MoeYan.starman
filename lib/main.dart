import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locales/flutter_locales.dart';
import '../views/register_view.dart';
import '../views/passcode_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'mm']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);

    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        locale: locale,
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,

        debugShowCheckedModeBanner: false,
        //home: PasscodeView(),
        home: RegisterView(),
      ),
    );
  }
}
