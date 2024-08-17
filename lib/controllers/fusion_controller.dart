import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starman/network/fusion_api.dart';

class FusionController {
  late SharedPreferences prefs;
  FusionController() {
    _initialize();
  }
  Future<void> _initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> starGroup(String starId) async {
    await _initialize();

    var queryParameters = {'starId': starId};
    var starGroup = await FusionApi().getStarGroup(
      'fusion_dev',
      'fusion_dev',
      '/rest/starman/getStarGroup',
      queryParameters,
    );
    if (starGroup.isNotEmpty) {
      await prefs.setString("_starGroup", starGroup);
      return true;
    } else {
      return false;
    }
  }

  Future<void> lastSubscription(String starId) async {
    await _initialize();
    try {
      var queryParameters = {'starId': starId};
      var lastSubscription = await FusionApi().getLastSubscription(
        'fusion_dev',
        'fusion_dev',
        '/rest/starman/getLastSubscription',
        queryParameters,
      );
      await prefs.setString('_lastSubscription', lastSubscription);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> starLinks(String starId) async {
    await _initialize();
    try {
      var queryParameters = {'starId': starId};
      var starLinks = await FusionApi().getStarLinks(
        'fusion_dev',
        'fusion_dev',
        '/rest/starman/getStarLinks',
        queryParameters,
      );
      await prefs.setString('_starLinks', starLinks);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> starSubscriptions(String starId) async {
    await _initialize();
    try {
      var queryParameters = {'starId': starId};
      var starSubscriptions = await FusionApi().getStarSubscriptions(
        'fusion_dev',
        'fusion_dev',
        '/rest/starman/getStarSubscriptions',
        queryParameters,
      );
      await prefs.setString('_starSubscriptions', starSubscriptions);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<File?> cfdData(String userId, String type) async {
    try {
      var queryParameters = {
        'user_id': userId,
        'type': type,
      };
      var response = await FusionApi().getCfdData(
        'fusion_dev',
        'fusion_dev',
        "/rest/starman/downloadFinancialReport",
        queryParameters,
      );
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/downloaded.zip';
      final file = File(filePath);
      return file.writeAsBytes(response.bodyBytes);
    } catch (e) {
      log(e.toString());
    }
  }
}
