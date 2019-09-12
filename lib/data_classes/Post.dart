import 'package:flutter_genesis_test/ui/utils/Commands.dart';
import 'package:sqflite/sqflite.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }


  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  @override
  String toString() {
    return 'Post{userId: $userId, id: $id, title: $title, body: $body}';
  }

  Future<void> insertPost(Post post) async {
    // Get a reference to the database.
    final Database db = await Commands.database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'posts',
      post.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Post>> getPosts() async {
    // Get a reference to the database.
    final Database db = await Commands.database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('posts');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Post(
        id: maps[i]['id'],
        userId: maps[i]['userId'],
        title: maps[i]['title'],
        body: maps[i]['body'],
      );
    });
  }

  Future<void> updatePost(Post post) async {
    // Get a reference to the database.
    final db = await Commands.database;

    // Update the given Dog.
    await db.update(
      'posts',
      post.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [post.id],
    );
  }

  Future<void> deletePost(int id) async {
    // Get a reference to the database.
    final db = await Commands.database;

    // Remove the Dog from the database.
    await db.delete(
      'posts',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }


}
