import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewErrorView extends StatefulWidget {
  const NewErrorView({super.key});

  @override
  State<NewErrorView> createState() => _NewErrorViewState();
}

class _NewErrorViewState extends State<NewErrorView> {
  @override
  void initState() {
    super.initState();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "logo",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Star Id',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            // user id

            Text(
              '1460-130F',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),

            SizedBox(
              height: 20,
            ),

            Text(
              "Your Trial Period (90) days is over.\nPlease contact\n09-42766768",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),

          ],
        ),
      ),
    );
  }
}