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

  Future<void> lastSubscription() async {
    try {
      var queryParameters = {'starId': '957a-562D'};
      var lastSubscription = await FusionApi().getLastSubscription(
        'fusion_dev',
        'fusion_dev',
        '/rest/starman/getLastSubscription',
        queryParameters,
      );
      await prefs.setString('_lastSubscription', lastSubscription.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Future<void> starLinks() async {
  //   try {
  //     var queryParameters = {'starId': '957a-562D'};
  //     var starLinks = await FusionApi().getStarLinks(
  //       'fusion_dev',
  //       'fusion_dev',
  //       '/rest/starman/getStarLinks',
  //       queryParameters,
  //     );
  //     await prefs.setString('_starLinks', starLinks.toString());
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
}
