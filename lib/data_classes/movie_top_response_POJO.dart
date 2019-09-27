import 'package:flutter_genesis_test/data_classes/movie_POJO.dart';

class MovieTopResponsePOJO {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<MoviePOJO> movies;

  MovieTopResponsePOJO(
      {this.page, this.totalPages, this.totalResults, this.movies});

  factory MovieTopResponsePOJO.fromJson(Map<String, dynamic> json){
    return MovieTopResponsePOJO(page: json["page"],
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
        movies: _parseMoviesFromJson(json["results"] as List));
  }

  static List<MoviePOJO> _parseMoviesFromJson(List listToParse) {
    List<MoviePOJO>resultList;
    resultList = listToParse.map((i) => MoviePOJO.fromJson(i)).toList();
    return resultList;
  }
}