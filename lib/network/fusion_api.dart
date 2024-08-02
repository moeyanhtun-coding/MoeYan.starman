import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

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
    var url = Uri.https('api.fusionmyanmar.com',
        '/rest/starman/getStarGroup', queryParameters);

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