import 'package:json_annotation/json_annotation.dart';
part 'generated/movie_api_model.g.dart';

@JsonSerializable()
class MovieApiModel {
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

  MovieApiModel(
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
      this.releaseDate});

  factory MovieApiModel.fromJson(Map<String, dynamic> json) => _$MovieApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieApiModelToJson(this);

}
