import 'package:flutter_genesis_test/data_classes/Pair.dart';
import 'package:flutter_genesis_test/data_classes/Post.dart';
import 'package:flutter_genesis_test/data_classes/response/PostResponse.dart';
import 'package:flutter_genesis_test/db/DatabaseHelper.dart';
import 'package:flutter_genesis_test/network/provider/PostApiProvider.dart';
import 'package:flutter_genesis_test/ui/utils/handlers/ErrorHandler.dart';

class PostRepository {
  PostApiProvider _apiProvider = PostApiProvider();
  final dbHelper = DatabaseHelper.instance;
  String error;

  Future<Pair> getUser() async {
    PostResponse response;
    try {
      response = await _apiProvider.getPosts();
    } catch (error) {
      this.error = handleError(error);
    }

    if (response.results != null) {
      await dbHelper.deleteAll();

      List<Map<String, dynamic>> listToInsert = List<Map<String, dynamic>>();
      response.results.forEach((each) {
        listToInsert.add(each.toMap());
      });
      await dbHelper.insertAll(listToInsert);
    } else {
      // TODO check do we need error here
    }

    dbHelper.queryRowCount().then((value) {
      print("dbHelper.queryRowCount() ${value}");
    });

    var result = queryPostsFromDb(dbHelper);
    if (result == null) {
      return Pair.withExpectedResult(result);
    } else {
      return Pair.withError(error);
    }
  }

  Future<List<Post>> queryPostsFromDb(DatabaseHelper dbHelper) async {
    List<Post> posts = new List();
    var queriedList = await dbHelper.queryAllRows();
    print("queriedList is ${queriedList.length}");

    queriedList.forEach((element) {
      posts.add(Post.fromJson(element));
    });
    return Future<List<Post>>.value(posts);
  }
}
