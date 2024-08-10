import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starman/widgets/navbar_widget.dart';
import '../controllers/fusion_controller.dart';
import '../models/star_group_model/star_group_model.dart';

late SharedPreferences prefs;
StarGroupModel? _starGroupModel;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    _getStarGroup();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _remainingBox();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _starGroupModel == null
          ? null
          : NavBar(
              starId: _starGroupModel!.starId.toString(),
              reaminingDate: "10",
            ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Page'),
        backgroundColor: Colors.grey[600],
      ),

      //body
      body: _starGroupModel == null
          ? const Center(
              child: CircularProgressIndicator()) // Show a loading indicator
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Home Page',
                    style: TextStyle(fontSize: 30.0),
                  ),
                ],
              ),
            ),
    );
  }

  //* StarGroup *//
  Future<void> _getStarGroup() async {
    prefs = await SharedPreferences.getInstance(); // Use the global `prefs`
    String? starGroupJson = prefs.getString('_starGroup');
    if (starGroupJson != null) {
      Map<String, dynamic> starGroupMap = jsonDecode(starGroupJson);
      StarGroupModel starGroup = StarGroupModel.fromJson(starGroupMap);
      setState(() {
        _starGroupModel = starGroup;
      });
    } else {
      log('No star group found in preferences');
    }
  }

  Future _remainingBox() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 243, 243),
          title: const Row(
            children: [
              Icon(
                Icons.circle_notifications,
                color: Colors.redAccent,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Day Remaining'),
            ],
          ),
          content: const Text('This is a dialog box.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
