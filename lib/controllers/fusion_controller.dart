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

  Future<void> starGroup() async {
    await _initialize();
    try {
      var queryParameters = {'starId': '957a-562D'};
      var starGroup = await FusionApi().getStarGroup(
          'fusion_dev',
          'fusion_dev',
          '/rest/starman/getStarGroup',
          queryParameters); // Assuming getStarGroup() is async
      await prefs.setString("_starGroup", starGroup.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
