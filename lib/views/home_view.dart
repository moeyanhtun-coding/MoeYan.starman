import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starman/models/star_links_model/star_links_model.dart';
import 'package:starman/widgets/navbar_widget.dart';
import '../controllers/fusion_controller.dart';
import '../models/last_subscription_model/last_subscription_model.dart';
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
  List<StarLinksModel>? _starLinksModel;
  LastSubscriptionModel? _lastSubscriptionModel;

  @override
  void initState() {
    super.initState();
    fusionController.starGroup('957a-562D');
    fusionController.lastSubscription('957a-562D');
    fusionController.starLinks('957a-562D');
    fusionController.starSubscriptions('957a-562D');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _remainingBox();
      _getStarGroup();
      _getLastSubscription();
      _getStarLinks();
      _getStarSubscriptions();
    });
  }

  Future<void> _getStarGroup() async {
    final prefs = await SharedPreferences.getInstance();
    String? starGroupJson = prefs.getString('_starGroup');
    if (starGroupJson != null) {
      Map<String, dynamic> starGroupMap = jsonDecode(starGroupJson);
      StarGroupModel starGroup = StarGroupModel.fromJson(starGroupMap);
      setState(() {
        _starGroupModel = starGroup;
      });
    } else {
      // Handle the case where the string is not available
      print('No star group found in preferences');
    }
  }

  Future<void> _getLastSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    String? lastSubscriptionJson = prefs.getString('_lastSubscription');

    if (lastSubscriptionJson != null) {
      Map<String, dynamic> lastSubscriptionMap =
          jsonDecode(lastSubscriptionJson);
      LastSubscriptionModel lastSubscription =
          LastSubscriptionModel.fromJson(lastSubscriptionMap);
      setState(() {
        _lastSubscriptionModel = lastSubscription;
      });
    } else {
      // Handle the case where the string is not available
      print('No star group found in preferences');
    }
  }

  Future<void> _getStarLinks() async {
    final prefs = await SharedPreferences.getInstance();
    String? starLinksJson = prefs.getString('_starLinks');
    var decodedJson = jsonDecode(starLinksJson!);
    if (starLinksJson != null) {
      List<Map<String, dynamic>> starLinksMap =
          List<Map<String, dynamic>>.from(decodedJson);
      List<StarLinksModel> starLinks =
          StarLinksModel.fromJsonList(starLinksMap);
      setState(() {
        _starLinksModel = starLinks;
      });
    }
  }

  Future<void> _getStarSubscriptions() async {
    final prefs = await SharedPreferences.getInstance();
    String? starSubscriptionsJson = prefs.getString("_starSubscriptions");
    print(starSubscriptionsJson);
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Home Page',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // _getStarLinks();
                      print(_starLinksModel.toString());
                    },
                    child: Text("Call Data"),
                  )
                ],
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
