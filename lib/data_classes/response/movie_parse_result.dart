import 'package:flutter_genesis_test/data_classes/movie_top_response_POJO.dart';

class MovieParceResult {
  final MovieTopResponsePOJO topResponse;
  final String error;

  MovieParceResult(this.topResponse, this.error);

  MovieParceResult.fromJson(Map<String, dynamic> json)
      : topResponse = MovieTopResponsePOJO.fromJson(json),
        error = "";

  MovieParceResult.withError(String errorValue)
      : topResponse = null,
        error = errorValue;
}
