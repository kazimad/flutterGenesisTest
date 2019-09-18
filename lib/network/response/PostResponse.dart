import 'package:flutter_genesis_test/data_classes/Post.dart';

class PostResponse {
  final List<Post> results;
  final String error;

  PostResponse(this.results, this.error);

  PostResponse.fromJson(Map<String, dynamic> json)
      : results = (json as List).map((i) => new Post.fromJson(i)).toList(),
        error = "";

  PostResponse.withError(String errorValue)
      : results = List(),
        error = errorValue;
}
