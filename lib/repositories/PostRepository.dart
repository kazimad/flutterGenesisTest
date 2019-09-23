import 'package:flutter_genesis_test/data_classes/Pair.dart';
import 'package:flutter_genesis_test/data_classes/Post.dart';
import 'package:flutter_genesis_test/data_classes/response/PostResponse.dart';
import 'package:flutter_genesis_test/db/DatabaseHelper.dart';
import 'package:flutter_genesis_test/network/provider/PostApiProvider.dart';
import 'package:flutter_genesis_test/ui/utils/handlers/ErrorHandler.dart';

class PostRepository {
  final PostApiProvider _apiProvider = PostApiProvider();
  final dbHelper = DatabaseHelper.instance;
  String error;
  PostResponse response;

  Future<Pair> getUser() async {
//    try {
      response = await _apiProvider.getPosts();
//    } catch (responseError) {
//      this.error = handleError(responseError);
//    }
    if (response.results != null) {
      await dbHelper.deleteAll();

      List<Map<String, dynamic>> listToInsert = List<Map<String, dynamic>>();
      response.results.forEach((each) {
        listToInsert.add(each.toMap());
      });
      await dbHelper.insertAll(listToInsert);
    } else {
      this.error = response.error;
    }

//    dbHelper.queryRowCount().then((value) {
//      print("dbHelper.queryRowCount() ${value}");
//    });

    var result = await queryPostsFromDb(dbHelper);
    Pair pairResult = Pair(result, error);
    return Future<Pair>.value(pairResult);
  }

  Future<List<Post>> queryPostsFromDb(DatabaseHelper dbHelper) async {
    List<Post> posts = new List();
    var queriedList = await dbHelper.queryAllRows();
    print("queriedList is ${queriedList.length}");

    queriedList.forEach((element) {
      posts.add(Post.fromJson(element));
    });
    print("posts is ${posts.length}");

    return Future<List<Post>>.value(posts);
  }
}
