import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_genesis_test/network/data_classes/Post.dart';
import 'package:http/http.dart' as http;

Future<List<Post>> fetchPosts() async {
  final response = await http.Client().get('https://jsonplaceholder.typicode.com/posts');
  return compute(parsePosts, response.body);
}

List<Post> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}
