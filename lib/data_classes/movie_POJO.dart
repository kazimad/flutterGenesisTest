import 'package:flutter_genesis_test/ui/utils/commands.dart';
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

  Map<String, dynamic> toMap() {
    return {
      'adult': adult == true ? 1 : 0,
      'backdrop_path': backdropPath,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video == true ? 1 : 0,
//      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

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

  factory MoviePOJO.fromDbJson(Map<String, dynamic> json) {
    return MoviePOJO(
      adult: fromJsonToBool(json['adult']),
      backdropPath: json['backdrop_path'],
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: fromJsonToBool(json['video']),
//      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }
  @override
  String toString() {
    return 'Movie{adult: $adult, backdropPath: $backdropPath, id: $id, originalLanguage: $originalLanguage,'
        'originalTitle: $originalTitle,overview: $overview, popularity: $popularity,'
        'posterPath: $posterPath, releaseDate: $releaseDate, title: $title,'
//        'video: $video, voteAverage: $voteAverage, voteCount: $voteCount}';
        'video: $video, voteCount: $voteCount}';
  }
}
