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

  Future<void> starGroup(String starId) async {
    await _initialize();
    try {
      var queryParameters = {'starId': starId};
      var starGroup = await FusionApi().getStarGroup(
          'fusion_dev',
          'fusion_dev',
          '/rest/starman/getStarGroup',
          queryParameters); // Assuming getStarGroup() is async
      await prefs.setString("_starGroup", starGroup);
    } catch (e) {
      throw Exception(e.toString());
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
        '/rest/starman/getStarLinks',
        queryParameters,
      );
      await prefs.setString('_starSubscriptions', starSubscriptions);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
