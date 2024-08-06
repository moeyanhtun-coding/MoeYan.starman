import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starman/widgets/navbar_widget.dart';
import '../controllers/fusion_controller.dart';
import '../models/star_group_model/star_group_model.dart';

late SharedPreferences prefs;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FusionController fusionController = FusionController();
  StarGroupModel? _starGroupModel;

  @override
  void initState() {
    super.initState();
    fusionController.starGroup();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _remainingBox();
      _showData();
    });
  }

  Future<void> _showData() async {
    final prefs = await SharedPreferences.getInstance();
    String? starGroupJson = prefs.getString('_starGroup');
    if (starGroupJson != null) {
      Map<String, dynamic> starGroupMap = jsonDecode(starGroupJson);
      StarGroupModel starGroupModel = StarGroupModel.fromJson(starGroupMap);
      setState(() {
        _starGroupModel = starGroupModel;
      });
    }
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
          : Center(
              child: Text(
                'Home Page',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
    );
  }

  Future _remainingBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 255, 243, 243),
            title: Row(
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
            content: Text('This is a dialog box.'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
