import 'package:flutter_genesis_test/data_classes/movie_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/movie_top_response_api_model.g.dart';

@JsonSerializable()
class MovieTopResponseApiModel {
  final int page;
  @JsonKey(name: 'total_results')
  final int totalResults;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'results')
  final List<MovieApiModel> movies;

  MovieTopResponseApiModel({this.page, this.totalPages, this.totalResults, this.movies});

  factory MovieTopResponseApiModel.fromJson(Map<String, dynamic> json) => _$MovieTopResponseApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieTopResponseApiModelToJson(this);
}
