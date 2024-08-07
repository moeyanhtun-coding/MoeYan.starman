import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starman/models/star_links_model/star_links_model.dart';
import 'package:starman/models/star_subscriptions_model/star_subscriptions_model.dart';
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
  List<StarSubscriptionsModel>? _starSubscriptonsModel;

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

  //* StarGroup *//
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
      print('No star group found in preferences');
    }
  }

  //* LastSubscription *//
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

  //* StarLinks *//
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

  //* StarSubscriptions *//
  Future<void> _getStarSubscriptions() async {
    final prefs = await SharedPreferences.getInstance();
    String? starSubscriptionsJson = prefs.getString("_starSubscriptions");
    var decodedJson = jsonDecode(starSubscriptionsJson!);
    if (starSubscriptionsJson != null) {
      List<Map<String, dynamic>> starSubscriptionsMap =
          List<Map<String, dynamic>>.from(decodedJson);
      List<StarSubscriptionsModel> starSubscriptions =
          StarSubscriptionsModel.fromJsonList(starSubscriptionsMap);
      setState(() {
        _starSubscriptonsModel = starSubscriptions;
      });
    } else {
      // Handle the case where the string is not available
      print('No star group found in preferences');
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
        });
  }
}
