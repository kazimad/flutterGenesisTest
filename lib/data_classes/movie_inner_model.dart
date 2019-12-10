import 'package:json_annotation/json_annotation.dart';

import 'movie_api_model.dart';

part 'generated/movie_inner_model.g.dart';

@JsonSerializable()
class MovieInnerModel {
  final int id;
  final double popularity;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  final bool video;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  final bool adult;
  @JsonKey(name: 'backdrop_path')
  final String backdropPath;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  final String title;
  final String overview;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'is_favorite')
  bool isFavorite;

  MovieInnerModel(
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

  factory MovieInnerModel.fromJson(Map<String, dynamic> json) => _$MovieInnerModelFromJson(json);

  factory MovieInnerModel.fromMoviePOJO(MovieApiModel moviePOJO) => _$MovieInnerModelFromMoviePOJO(moviePOJO);

  Map<String, dynamic> toJson() => _$MovieInnerModelToJson(this);

  @override
  String toString() {
    return 'MovieInner{adult: $adult, backdropPath: $backdropPath, id: $id, originalLanguage: $originalLanguage,'
        'originalTitle: $originalTitle,overview: $overview, popularity: $popularity,'
        'posterPath: $posterPath, releaseDate: $releaseDate, title: $title,'
        'video: $video, voteCount: $voteCount, is_favorite: $isFavorite';
  }
}
