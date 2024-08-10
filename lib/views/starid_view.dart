import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starman/controllers/fusion_controller.dart';
import 'package:starman/main.dart';
import 'package:starman/models/last_subscription_model/last_subscription_model.dart';
import 'package:starman/models/star_group_model/star_group_model.dart';
import 'package:starman/models/star_links_model/star_links_model.dart';
import 'package:starman/models/star_subscriptions_model/star_subscriptions_model.dart';
import 'package:starman/widgets/custom_textformfield_widget.dart';
import 'package:starman/widgets/language_switch_widget.dart';

late SharedPreferences prefs;

class StaridView extends StatefulWidget {
  const StaridView({super.key});

  @override
  State<StaridView> createState() => _StaridViewState();
}

class _StaridViewState extends State<StaridView> {
  final TextEditingController _controller = TextEditingController();
  final FusionController fusionController = FusionController();
  StarGroupModel? _starGroupModel;
  String? starId = '';
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  _logo(),
                  SizedBox(height: 50),
                  const Text(
                    'Welcome to StarMan',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50),

                  LanguageButtonWidget(),
                  SizedBox(height: 30),

                  const Text(
                    'Please Enter Registered StarID',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomTextFieldWidget(
                    label: 'Star Id',
                    icon: Icons.star,
                    controller: _controller,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 70),
          child: ElevatedButton(
            onPressed: _isButtonDisabled
                ? null
                : () async {
              setState(() {
                _isButtonDisabled = true;
                starId = _controller.text;
              });

              bool isGetData = await fusionController.starGroup(starId!);
              if (isGetData) {
                await _getData();
              } else {
                _showAlertDialog(context);
              }

              setState(() {
                _isButtonDisabled = false; // Re-enable the button
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              elevation: 1,
              minimumSize: const Size(double.infinity, 40),
            ),
            child: const Text(
              'Enter',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(
                Icons.notification_important_rounded,
                color: Colors.redAccent,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "StarId Not Found!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.sizeOf(context).width * 0.048),
              ),
            ],
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please Call Service Center.'),
                Text('Phone - 09890630456'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  _getData() async {
    prefs = await SharedPreferences.getInstance();
    await _getStarGroup();
    if (_starGroupModel != null) {
      fusionController.lastSubscription(starId!);
      fusionController.starLinks(starId!);
      fusionController.starSubscriptions(starId!);
      await prefs.setString("_starId", starId!);
      Get.offAllNamed('/passcode');
    } else {
      log("not found");
    }
  }

  Widget _logo() {
    return Center(
      child: Image.asset(
        'assets/logo.png',
        height: 120,
      ),
    );
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
      log('No star group found in preferences');
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
    } else {
      log('No star group found in preferences');
    }
  }

  //* StarLinks *//
  Future<void> _getStarLinks() async {
    final prefs = await SharedPreferences.getInstance();
    String? starLinksJson = prefs.getString('_starLinks');
    if (starLinksJson != null) {
      var decodedJson = jsonDecode(starLinksJson);
      List<Map<String, dynamic>> starLinksMap =
          List<Map<String, dynamic>>.from(decodedJson);
      List<StarLinksModel> starLinks =
          StarLinksModel.fromJsonList(starLinksMap);
    } else {
      log("No star links found in preferences");
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
    } else {
      // Handle the case where the string is not available
      log('No star group found in preferences');
    }
  }
}
