import 'dart:convert';

import 'package:http/http.dart' as http;

//void onButtonClick() async {
//  try {
//    var value = await http.get('https://jsonplaceholder.typicode.com/posts/1');
//  } catch(_) {
//    enableInputs();
//    print('WTF');
//  }
//}

Future<Post> fetchPost() async {
  try {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/posts/1');
    if (response.statusCode == 200) {
      print('myLog: ${response.statusCode}');

      // If the call to the server was successful, parse the JSON.
      return Post.fromJson(json.decode(response.body));
    } else {
      print('myLog: else is ${response.statusCode}');

      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  } catch (_) {
    print('myLog: ${_.toString()}');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

//
//import 'package:flutter/material.dart';
//
//class Post {
//  final int userId;
//  final int id;
//  final String title;
//  final String body;
//
//  Post({
//    @required this.userId,
//    @required this.id,
//    @required this.title,
//    @required this.body});
//}
