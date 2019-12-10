// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../movie_inner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieInnerModel _$MovieInnerModelFromJson(Map<String, dynamic> json) {
  return MovieInnerModel(
      id: json['id'] as int,
      popularity: (json['popularity'] as num)?.toDouble(),
      voteCount: json['vote_count'] as int,
      video: json['video'] as int == 1 ? true : false,
      posterPath: json['poster_path'] as String,
      adult: json['adult'] as int == 1 ? true : false,
      backdropPath: json['backdrop_path'] as String,
      originalLanguage: json['original_language'] as String,
      originalTitle: json['original_title'] as String,
      title: json['title'] as String,
      overview: json['overview'] as String,
      releaseDate: json['release_date'] as String,
      isFavorite: json['is_favorite'] as int == 1 ? true : false);
}

MovieInnerModel _$MovieInnerModelFromMoviePOJO(MovieApiModel moviePOJO){
      return MovieInnerModel(
          id: moviePOJO.id,
          popularity: moviePOJO.popularity,
          voteCount: moviePOJO.voteCount,
          video: moviePOJO.video == 1 ? true : false,
          posterPath: moviePOJO.posterPath,
          adult: moviePOJO.adult == 1 ? true : false,
          backdropPath: moviePOJO.backdropPath,
          originalLanguage: moviePOJO.originalLanguage,
          originalTitle: moviePOJO.originalTitle,
          title: moviePOJO.title,
          overview: moviePOJO.overview,
          releaseDate: moviePOJO.releaseDate,
          isFavorite: false);
}

Map<String, dynamic> _$MovieInnerModelToJson(MovieInnerModel instance) =>
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
      'release_date': instance.releaseDate,
      'is_favorite': instance.isFavorite
    };
