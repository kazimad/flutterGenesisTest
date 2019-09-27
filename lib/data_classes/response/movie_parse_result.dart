import 'package:flutter_genesis_test/data_classes/movie_top_response_POJO.dart';

class MovieParceResult {
  final MovieTopResponsePOJO topResponse;
  final String error;

  MovieParceResult(this.topResponse, this.error);

  // probably in real life - I will need this line, currently it is commented
  MovieParceResult.fromJson(Map<String, dynamic> json)
//  PostResponse.fromJson(List<dynamic> json)
      : topResponse = MovieTopResponsePOJO.fromJson(json),
        error = "";

  MovieParceResult.withError(String errorValue)
      : topResponse = null,
        error = errorValue;
}
