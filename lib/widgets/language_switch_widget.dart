import 'package:flutter/material.dart';

class LanguageButtonWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('EN'),

        Text('မြန်မာ'),
      ],
    );
  }
}
