import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  try {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/posts/1');
    if (response.statusCode == 200) {
      print('myLog: ${response.statusCode}');
      Post postResult = Post.fromJson(json.decode(response.body));
      print('myLog: response is ${postResult.id}');
      print('myLog: response is ${postResult.body}');
      print('myLog: response is ${postResult.title}');

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


//Future<String> fetchPost() async {
//  //we have to wait to get the data so we use 'await'
//  http.Response response = await http.get(
//    //Uri.encodeFull removes all the dashes or extra characters present in our Uri
//      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
//      headers: {
//        //if your api require key then pass your key here as well e.g "key": "my-long-key"
//        "Accept": "application/json"
//      }
//  );
//
//  //print(response.body);
//
//  List data = json.decode(response.body);
//  //print(data);
//  print(data[1]["title"]); // it will print => title: "qui est esse"
//}




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
