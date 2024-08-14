import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starman/models/last_subscription_model/last_subscription_model.dart';
import 'package:starman/models/star_group_model/star_group_model.dart';
import 'package:starman/widgets/navbar_widget.dart';

late SharedPreferences prefs;
StarGroupModel? _starGroupModel;

class CfdReportView extends StatefulWidget {
  const CfdReportView({super.key});

  @override
  State<CfdReportView> createState() => _CfdReportViewState();
}

class _CfdReportViewState extends State<CfdReportView> {
  int? _reamaingDay;
  LastSubscriptionModel? _lastSubscriptionModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _getStarGroup();
    await _getLastSubscription();
    _reamaingDay = await _remainingDate();
    if (_reamaingDay! < 10) {
      _remainingBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: _starGroupModel == null
            ? null
            : NavBar(
                starId: _starGroupModel!.starId.toString(),
                reaminingDate: _reamaingDay.toString(),
              ),
        appBar: AppBar(
          title: Text(
            'ငွေအဝင်အထွက်အစီရင်ခံစာ',
            style: TextStyle(fontSize: size(0.045)),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.cloud_download,
                size: MediaQuery.sizeOf(context).width * 0.07,
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.03,
            ),
          ],
          backgroundColor: Colors.grey[600],
        ),
        body: _starGroupModel == null
            ? const Center(
                child: CircularProgressIndicator(),
              ) // Show a loading indicator
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: ListView(
                  children: [
                    _totalCashInOut(89400, 0),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).width * 0.02,
                    ),
                    _cashInTable(),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).width * 0.02,
                    ),
                    _cashOutTable(),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).width * 0.02,
                    ),
                    Container(
                      color: Colors.greenAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "စုစုပေါင်း(MMK)",
                              style: TextStyle(
                                fontSize: size(0.035),
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '894000',
                              style: TextStyle(
                                fontSize: size(0.035),
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _cashInTable() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.shade900,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Shadow color with opacity
              spreadRadius: 1, // How much the shadow spreads
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(
              color: Colors.blue.shade700,
              width: 2,
              style: BorderStyle.solid) // Optional: Add rounded corners
          ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ငွေအဝင်",
                  style: TextStyle(
                    fontSize: size(0.04),
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Divider(
                height: 2,
                color: Colors.blue.shade600,
              ),
              _cashRow('ရောင်းရငွေ', 894000),
              _cashRow('တခြားတင်ငွေ', 0),
              _cashRow('ကုန်ဝယ်သူမှပေးချေငွေ', 0),
              Divider(
                height: 2,
                color: Colors.blue.shade600,
              ),
            ],
          ),
          _totalCashRow('စုစုပေါင်းငွေအဝင်', 894000)
        ],
      ),
    );
  }

  Widget _cashOutTable() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.shade900,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Shadow color with opacity
              spreadRadius: 1, // How much the shadow spreads
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(
              color: Colors.blue.shade700,
              width: 2,
              style: BorderStyle.solid) // Optional: Add rounded corners
          ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ငွေအထွက်",
                  style: TextStyle(
                    fontSize: size(0.04),
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Divider(
                height: 2,
                color: Colors.blue.shade600,
              ),
              _cashRow('ကုန်ဝယ်ငွေ', 0),
              _cashRow('တခြားအသုံးစရိတ်', 0),
              _cashRow('ကုန်ရောင်းသူအားပေးချေငွေ', 0),
              Divider(
                height: 2,
                color: Colors.blue.shade600,
              ),
              _cashMinusRow('ပိုင်ရှင်ထံအမ်းငွေ', 0),
              Divider(
                height: 2,
                color: Colors.blue.shade600,
              ),
            ],
          ),
          _totalCashRow('စုစုပေါင်းငွေအထွက်', 0)
        ],
      ),
    );
  }

  Widget _totalCashRow(String title, int price) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: size(0.04),
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$price MMK',
            style: TextStyle(
              fontSize: size(0.04),
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget _cashRow(String title, int price) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: size(0.0365),
                color: Colors.white,
                fontWeight: FontWeight.w300),
          ),
          Text(
            '$price',
            style: TextStyle(fontSize: size(0.038), color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _cashMinusRow(String title, int price) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: size(0.0365),
                color: Colors.white,
                fontWeight: FontWeight.w300),
          ),
          Text(
            '($price)',
            style: TextStyle(fontSize: size(0.038), color: Colors.white),
          ),
        ],
      ),
    );
  }

  double size(double factor) {
    return MediaQuery.sizeOf(context).width * factor;
  }

  Widget _totalCashInOut(
    int cashInPrice,
    int cashOutPrice,
  ) {
    return Container(
      color: Colors.greenAccent,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).width * 0.03),
        child: Row(
          children: [
            Expanded(child: _totalCash("စုစုပေါင်းငွေအဝင်", cashInPrice)),
            Expanded(child: _totalCash("စုစုပေါင်းငွေအထွက်", cashOutPrice)),
          ],
        ),
      ),
    );
  }

  Widget _totalCashContainer(
    int totalCash,
  ) {
    return Container(
      color: Colors.greenAccent,
      child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.sizeOf(context).width * 0.03),
          child: _cashRow('စုစုပေါင်း(MMK)', 84900)),
    );
  }

  Widget _totalCash(String title, int price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: MediaQuery.sizeOf(context).width * 0.038,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).width * 0.02,
        ),
        Text(
          '$price MMK',
          style: TextStyle(
            fontSize: MediaQuery.sizeOf(context).width * 0.038,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
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
      log('No last subscription found in preferences');
    }
  }

  Future<int> _remainingDate() async {
    String endDateString =
        (_lastSubscriptionModel?.licenseInfo?.endDate).toString();
    DateTime endDate = DateFormat('dd/MM/yyyy').parse(endDateString);
    DateTime currentDate = DateTime.now();
    int remainingDays = endDate.difference(currentDate).inDays;
    return remainingDays;
  }

  Future<void> _remainingBox() async {
    await showDialog(
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
          content:
              Text('Your subscribtion is only ${_reamaingDay.toString()} left'),
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
