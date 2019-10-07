import 'package:flutter_genesis_test/ui/utils/commands.dart';

// need to add in this pojo field isFavorite
class MoviePOJO {
  final int id;
  final double popularity;
  final int voteCount;
  final bool video;
  final String posterPath;
  final bool adult;
  final String backdropPath;
  final String originalLanguage;
  final String originalTitle;
  final String title;
  // TODO try too Google it
//  final double voteAverage;
  final String overview;
  final String releaseDate;

  MoviePOJO(
      {this.id,
      this.popularity,
      this.voteCount,
      this.video,
      this.posterPath,
      this.adult,
      this.backdropPath,
      this.originalLanguage,
      this.originalTitle,
      this.title,
//      this.voteAverage,
      this.overview,
      this.releaseDate});

  factory MoviePOJO.fromJson(Map<String, dynamic> json) {
    return MoviePOJO(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
//      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }
}
