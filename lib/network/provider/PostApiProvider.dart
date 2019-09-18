import 'package:dio/dio.dart';
import 'package:flutter_genesis_test/network/response/PostResponse.dart';

class PostApiProvider{
  final String _endpoint = "https://jsonplaceholder.typicode.com/posts";
  final Dio _dio = Dio();

  Future<PostResponse> getPosts() async {
    try {
      Response response = await _dio.get(_endpoint);
      return PostResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PostResponse.withError("$error");
    }
  }
}