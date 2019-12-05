import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String validatePosterPath(MovieInner movie) {
  if (movie.posterPath != null) {
    return BASE_IMAGE_LINK + movie.posterPath;
  } else {
    return "";
  }
}

Future<dynamic> getProfile(String accessToken) async {
  var graphResponse =
  await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=$accessToken');
  var profile = json.decode(graphResponse.body);
  return profile;
}