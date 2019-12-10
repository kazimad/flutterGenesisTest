// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../movie_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieApiModel _$MovieApiModelFromJson(Map<String, dynamic> json) {
  return MovieApiModel(
      id: json['id'] as int,
      popularity: (json['popularity'] as num)?.toDouble(),
      voteCount: json['vote_count'] as int,
      video: json['video'] as bool,
      posterPath: json['poster_path'] as String,
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String,
      originalLanguage: json['original_language'] as String,
      originalTitle: json['original_title'] as String,
      title: json['title'] as String,
      overview: json['overview'] as String,
      releaseDate: json['release_date'] as String);
}

Map<String, dynamic> _$MovieApiModelToJson(MovieApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'popularity': instance.popularity,
      'vote_count': instance.voteCount,
      'video': instance.video,
      'poster_path': instance.posterPath,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'title': instance.title,
      'overview': instance.overview,
      'release_date': instance.releaseDate
    };
