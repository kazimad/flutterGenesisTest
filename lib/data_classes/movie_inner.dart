import 'package:flutter_genesis_test/data_classes/movie_api.dart';
import 'package:flutter_genesis_test/ui/utils/commands.dart';

class MovieInner {
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
  final String overview;
  final String releaseDate;
  bool isFavorite;

  MovieInner({this.id,
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.title,
    this.overview,
    this.releaseDate,
    this.isFavorite});

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
      'vote_count': voteCount,
      'is_favorite': isFavorite == true ? 1 : 0
    };
  }

  factory MovieInner.fromDbJson(Map<String, dynamic> json) {
    return MovieInner(
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
        voteCount: json['vote_count'],
        isFavorite: fromJsonToBool(json['is_favorite']));
  }

  factory MovieInner.fromMoviePOJO(MovieApi moviePOJO){
    return MovieInner(
        id: moviePOJO.id,
        popularity: moviePOJO.popularity,
        voteCount: moviePOJO.voteCount,
        video: moviePOJO.video,
        posterPath: moviePOJO.posterPath,
        adult: moviePOJO.adult,
        backdropPath: moviePOJO.backdropPath,
        originalLanguage : moviePOJO.originalLanguage,
        originalTitle : moviePOJO.originalTitle,
        title : moviePOJO.title,
        overview: moviePOJO.overview,
        releaseDate : moviePOJO.releaseDate,
        isFavorite: false);
  }

  @override
  String toString() {
    return 'MovieInner{adult: $adult, backdropPath: $backdropPath, id: $id, originalLanguage: $originalLanguage,'
        'originalTitle: $originalTitle,overview: $overview, popularity: $popularity,'
        'posterPath: $posterPath, releaseDate: $releaseDate, title: $title,'
        'video: $video, voteCount: $voteCount, is_favorite: $isFavorite';
  }
}
