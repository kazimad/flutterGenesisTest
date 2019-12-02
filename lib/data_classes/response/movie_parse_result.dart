import 'package:flutter_genesis_test/data_classes/movie_top_response_api.dart';

class MovieParceResult {
  final MovieTopResponseApi topResponse;
  final String error;

  MovieParceResult(this.topResponse, this.error);

  MovieParceResult.fromJson(Map<String, dynamic> json)
      : topResponse = MovieTopResponseApi.fromJson(json),
        error = "";

  MovieParceResult.withError(String errorValue)
      : topResponse = null,
        error = errorValue;
}
