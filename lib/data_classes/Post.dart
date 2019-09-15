import 'package:flutter_genesis_test/ui/utils/DatabaseHelper.dart';
import 'package:flutter_genesis_test/ui/utils/Constants.dart';
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

//  static Future<void> insertAllPosts(List<Post> postsToInsert) async {
//    Future<Database> fdb = DatabaseHelper.;
//    fdb.then((value) {
//      var batch = value.batch();
//      postsToInsert.forEach((element) => {
//            batch.insert(DB_NAME, element.toMap(),
//                conflictAlgorithm: ConflictAlgorithm.replace)
//          });
//      batch.commit();
//    });
//  }
//
//  static Future<void> insertPost(Post post) async {
//    final Database db = await DatabaseHelper.database;
//    await db.insert(
//      DB_NAME,
//      post.toMap(),
//      // TODO be noticed thet there is a come at the end, check - does it have to be here
//      conflictAlgorithm: ConflictAlgorithm.replace,
//    );
//  }
//
//  static Future<List<Post>> getPosts() async {
//    final Database db = await DatabaseHelper.database;
//    final List<Map<String, dynamic>> maps = await db.query(DB_NAME);
//    return List.generate(maps.length, (i) {
//      return Post(
//          id: maps[i]['id'],
//          userId: maps[i]['userId'],
//          title: maps[i]['title'],
//          body: maps[i]['body']);
//    });
//  }
//
//  static Future<void> updatePost(Post post) async {
//    final db = await DatabaseHelper.database;
//    await db
//        .update(DB_NAME, post.toMap(), where: "id = ?", whereArgs: [post.id]);
//  }
//
//  static Future<void> deleteBatchOfPosts(List<Post> postsToDelete) async {
//    final db = await DatabaseHelper.database;
//    var batch = db.batch();
//    postsToDelete.forEach((element) => {
//          batch.delete(
//            DB_NAME,
//            where: "id = ?",
//            whereArgs: [element.id],
//          )
//        });
//    await batch.commit();
//  }
//
////  static Future<void> deleteAllInTable() async {
////    Future<Database> fdb = Commands.database;
////    fdb.then((value) {
////      value == null
////          ? print("deleteAllInTable db == null")
////          : print("deleteAllInTable db != null");
////      value.execute("DELETE FROM $DB_NAME");
////    }).catchError((error) => {print("deleteAllInTable $error")});
////  }
//
//  deleteAll() async {
//    final db = await DatabaseHelper.;
//    db.rawDelete("Delete * from Client");
//  }
//
//  static Future<void> deletePost(int id) async {
//    final db = await DatabaseHelper.database;
//    await db.delete(DB_NAME, where: "id = ?", whereArgs: [id]);
//  }
}
