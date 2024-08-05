import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LanguageButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('EN'),
        Switch(
          value: Locales.currentLocale(context)?.languageCode == 'mm',
          onChanged: (value) {
            // Locales.change(context, value ? 'mm' : 'en');
          },
        ),
        Text('မြန်မာ'),
      ],
    );
  }
}
