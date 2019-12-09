import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> getProfile(String accessToken) async {
  var graphResponse =
      await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=$accessToken');
  var profile = json.decode(graphResponse.body);
  return profile;
}
