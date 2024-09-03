import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starman/models/cf_model/cf_model.dart';
import 'package:starman/models/last_subscription_model/last_subscription_model.dart';
import 'package:starman/models/star_group_model/star_group_model.dart';
import 'package:starman/models/star_links_model/star_links_model.dart';
import 'package:starman/widgets/navbar_widget.dart';

import '../../controllers/fusion_controller.dart';

late SharedPreferences prefs;
StarGroupModel? _starGroupModel;
const String filePath =
    "/data/user/0/com.example.starman/app_flutter/StarCFD.json";

class CfDailyReportView extends StatefulWidget {
  const CfDailyReportView({super.key});

  @override
  State<CfDailyReportView> createState() => _CfDailyReportViewState();
}


class _CfDailyReportViewState extends State<CfDailyReportView> {

  final FusionController fusionController = FusionController();
  int? _reamaingDay;
  List<String> _warehouse = [];
  LastSubscriptionModel? _lastSubscriptionModel;
  String _selectedWarehouse = "Warso"; // Default warehouse selection
  String _selectedDateFilter = 'Today'; // Default date filter selection
  List<StarLinksModel>? _starLinksModel;
  CfModel? thisMonthData;

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
    await _getStarLinks();
    await _getWarehouse();
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
              onPressed: () async {
                await _getCfData();
              },
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
        )
            : Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: ListView(
            children: [
              _buildWarehouseDropdown(),
              const SizedBox(height: 0.1),
              // _buildDateFilterDropdown(),
              _totalCashInOut(89400, 0),


            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarehouseDropdown() {
    return Row(
      children: [
        _warehouse.isNotEmpty
            ? DropdownButton<String>(
          value: _selectedWarehouse,
          onChanged: (String? newValue) {
            setState(() {
              _selectedWarehouse = newValue!;
            });
          },
          items: _warehouse.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            );
          }).toList(),
          underline:
          const SizedBox(), // Removes underline from DropdownButton
          style: const TextStyle(color: Colors.black, fontSize: 13),
        )
            : const SizedBox
            .shrink(), // Return an empty widget if _warehouse is empty
        const Spacer(),
        Text(
          DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now()),
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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

  Future<void> _getCfData() async {
    try {
      await _downLoadData();
      await _getCf("This Month");
      await _getStarLinks();
    } catch (e) {
      log('Error in _getCfData: $e');
    }
  }

  Future<void> _downLoadData() async {
    try {
      var file = await fusionController.reportData("BF76-FE5F-6DD0-9FFD", "CFD");

      if (file != null) {
        await extractZipFile(file);
        String cfdJson = await readJsonFile(filePath);
        await prefs.setString("_satrCFD", cfdJson);
        log("File Download Success");
      } else {
        log("File download failed");
      }
    } catch (e) {
      log('Error during download: $e');
    }
  }

  Future<void> extractZipFile(File zipFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final extractionPath = directory.path;

      await Directory(extractionPath).create(recursive: true);
      Archive archive = ZipDecoder().decodeBytes(
        zipFile.readAsBytesSync(),
        verify: true,
        password: 'Digital Fusion 2018',
      );
//dev code
      log('Archive contains ${archive.length} files:');
      for (final file in archive) {
        final filename = '$extractionPath/${file.name}';
        if (file.isFile) {
          final outFile = File(filename);
          await outFile.create(recursive: true);
          await outFile.writeAsBytes(file.content as List<int>);
        } else {
          // If it's a directory, ensure it exists
          await Directory(filename).create(recursive: true);
          log('Directory created: $filename');
        }
      }
    } catch (e, stacktrace) {
      log('Error during extraction: $e');
      log('Stacktrace: $stacktrace');
    }
  }

  Future<void> _getWarehouse() async {
    if (_starLinksModel != null) {
      for (int i = 0; i < _starLinksModel!.length; i++) {
        _warehouse.add(_starLinksModel![i].warehouseName.toString());
      }
    }

    log(_warehouse.toString());
  }

  Future<String> readJsonFile(String path) async {
    try {
      final file = File(path);
      // Check if the file exists
      if (await file.exists()) {
        // Read the file as a string
        String contents = await file.readAsString();
        return contents;
      } else {
        throw Exception("File not found at $path");
      }
    } catch (e) {
      throw Exception("Error reading file: $e");
    }
  }

  Future<void> _getCf(String date) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? starCf = prefs.getString('_satrCF');
      if (starCf != null) {
        var decodeJson = jsonDecode(starCf);
        List<Map<String, dynamic>> starCfList =
        List<Map<String, dynamic>>.from(decodeJson);
        List<CfModel> cfData = CfModel.fromJsonList(starCfList);
        log(cfData.toString());
        thisMonthData = cfData.firstWhere((x) => x.starFilter == date);
        log(thisMonthData.toString());
      }
    } catch (e) {
      log('Error in _getCf: $e');
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
      _starLinksModel = starLinks;
    } else {
      log("No star links found in preferences");
    }
  }
}
