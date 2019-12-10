// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../movie_top_response_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieTopResponseApiModel _$MovieTopResponseApiModelFromJson(
    Map<String, dynamic> json) {
  return MovieTopResponseApiModel(
      page: json['page'] as int,
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
      movies: (json['results'] as List)
          ?.map((e) => e == null
              ? null
              : MovieApiModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$MovieTopResponseApiModelToJson(
        MovieTopResponseApiModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
      'results': instance.movies
    };
