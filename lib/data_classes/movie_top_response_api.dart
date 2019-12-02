import 'package:flutter_genesis_test/data_classes/movie_api.dart';

class MovieTopResponseApi {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<MovieApi> movies;

  MovieTopResponseApi(
      {this.page, this.totalPages, this.totalResults, this.movies});

  factory MovieTopResponseApi.fromJson(Map<String, dynamic> json){
    return MovieTopResponseApi(page: json["page"],
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
        movies: _parseMoviesFromJson(json["results"] as List));
  }

  static List<MovieApi> _parseMoviesFromJson(List listToParse) {
    List<MovieApi>resultList;
    resultList = listToParse.map((i) => MovieApi.fromJson(i)).toList();
    return resultList;
  }
}