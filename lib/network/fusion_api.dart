import 'dart:convert';
import 'dart:js_interop';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import '../models/last_subscription_model/last_subscription_model.dart';
import '../models/star_group_model/star_group_model.dart';
import '../models/star_links_model/star_links_model.dart';
import '../models/star_subscriptions_model/star_subscriptions_model.dart';

//* Common PostRequestAPI *//
Future<http.Response> _makePostRequest({
  required String endpoint,
  required Map<String, String> queryParams,
  required String username,
  required String password,
}) async {
  try {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    var url = Uri.https('api.fusionmyanmar.com', endpoint, queryParams);
    final response = await http.post(
      url,
      headers: {
        'Authorization': basicAuth,
        'SECRET_ACCESS_TOKEN':
            "\$2a\$10\$wl2BjK4NHQwB6npW2xOWCOyFN/x3s92TKnLdSDFSVnTCuxIDg8mVG",
      },
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Request failed with status: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Request error: ${e.toString()}");
  }
}

class FusionApi {
  //* SatrGroupAPI *//
  Future<String> getStarGroup(
    String username,
    String password,
    String endpoint,
    Map<String, String> queryParams,
  ) async {
    try {
      final response = await _makePostRequest(
        endpoint: endpoint,
        queryParams: queryParams,
        username: username, // Replace with your actual username
        password: password, // Replace with your actual password
      );
      return response.body;
    } catch (e) {
      throw Exception("Error getting star group: ${e.toString()}");
    }
  }

//* LastSubscriptionAPI *//
  Future<LastSubscriptionModel> getLastSubscription(
    String username,
    String password,
    String endpoint,
    Map<String, String> queryParams,
  ) async {
    try {
      final response = await _makePostRequest(
        endpoint: endpoint,
        queryParams: queryParams,
        username: username,
        password: password,
      );
      return LastSubscriptionModel.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception("Error getting star group: ${e.toString()}");
    }
  }

  // //* StarLinksAPI *//
  // Future<String> getStarLinks(
  //   String username,
  //   String password,
  //   String endpoint,
  //   Map<String, String> queryParams,
  // ) async {
  //   try {
  //     final response = await _makePostRequest(
  //       endpoint: endpoint,
  //       queryParams: queryParams,
  //       username: username, // Replace with your actual username
  //       password: password, // Replace with your actual password
  //     );
  //     List<dynamic> body = json.decode(response.body);
  //     return body.toString();
  //   } catch (e) {
  //     throw Exception("Error getting star group: ${e.toString()}");
  //   }
  // }

  //* StarSubscriptionsAPI *//
  Future<List<StarSubscriptionsModel>> getStarSubscriptions(
    String username,
    String password,
    String endpoint,
    Map<String, String> queryParams,
  ) async {
    try {
      final response = await _makePostRequest(
        endpoint: endpoint,
        queryParams: queryParams,
        username: username, // Replace with your actual username
        password: password, // Replace with your actual password
      );
      List<dynamic> body = json.decode(response.body);
      return body
          .map((dynamic item) => StarSubscriptionsModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception("Error getting star group: ${e.toString()}");
    }
  }
}

/*

https://api.fusionmyanmar.com/rest/starman/getStarGroup

Method = POST ,Param {starId}

https://api.fusionmyanmar.com/rest/starman/getStarLinks

Method = POST ,Param {starId}

https://api.fusionmyanmar.com/rest/starman/getLastSubscription

Method = POST ,Param {starId}

https://api.fusionmyanmar.com/rest/starman/getStarSubscriptions

Method = POST ,Param {starId}

*/
class APIDemo {
  void httpGet() async {
    String username = 'fusion_dev';
    String password = 'fusion_dev';
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    dev.log(basicAuth);

    var queryParameters = {'starId': '957a-562D'};
    var url = Uri.https(
        'api.fusionmyanmar.com', '/rest/starman/getStarGroup', queryParameters);

    var response = await http.post(url, headers: <String, String>{
      'Authorization': basicAuth,
      'SECRET_ACCESS_TOKEN':
          "\$2a\$10\$wl2BjK4NHQwB6npW2xOWCOyFN/x3s92TKnLdSDFSVnTCuxIDg8mVG"
    });
    dev.log(response.body);
  }
}

// For FusionAPI Testing with POSTMAN
/*

SECRET_ACCESS_TOKEN
$2a$10$wl2BjK4NHQwB6npW2xOWCOyFN/x3s92TKnLdSDFSVnTCuxIDg8mVG

Authorization
Basic MjhQS2RmMjY6ODAxNmZlNmIyNTExNzljMTI3OTU3ZTE4ZDM=


https://api.fusionmyanmar.com/rest/starman/getStarGroup?starId=957a-562D

https://api.fusionmyanmar.com/rest/starman/getStarLinks?starId=957a-562D

https://api.fusionmyanmar.com/rest/starman/getLastSubscription?starId=957a-562D

https://api.fusionmyanmar.com/rest/starman/getStarSubscriptions?starId=957a-562D


*/
