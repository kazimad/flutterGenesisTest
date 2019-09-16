import 'package:flutter_genesis_test/data_classes/Post.dart';
import 'package:flutter_genesis_test/network/sources/FilmUrlSource.dart';
import 'package:flutter_genesis_test/ui/utils/DatabaseHelper.dart';

class PostRepository {
  static Future<List<Post>> getPosts() async {
    final dbHelper = DatabaseHelper.instance;
    List<Post> result = new List();

    List<Post> postsFromNetwork = await fetchPosts();
    // ignore: null_aware_in_condition
    if (postsFromNetwork?.isNotEmpty) {
      await dbHelper.deleteAll();
      await dbHelper.insert(postsFromNetwork[0].toMap());
      print("dbHelper.queryRowCount() is ${await dbHelper.queryRowCount()}");
    }
    var queriedList = await dbHelper.queryAllRows();
    queriedList.forEach((element) {
      result.add(Post.fromJson(element));
    });
    return result;
  }
}
