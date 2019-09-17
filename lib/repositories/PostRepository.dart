import 'package:flutter_genesis_test/data_classes/Pair.dart';
import 'package:flutter_genesis_test/data_classes/Post.dart';
import 'package:flutter_genesis_test/network/sources/FilmUrlSource.dart';
import 'package:flutter_genesis_test/ui/utils/DatabaseHelper.dart';

Future<Pair> getPosts() async {
  final dbHelper = DatabaseHelper.instance;
  List<Post> resultList;
  String resultError;
  try {
    List<Post> postsFromNetwork = await fetchPosts();
// ignore: null_aware_in_condition
    if (postsFromNetwork?.isNotEmpty) {
      await dbHelper.deleteAll();
      await dbHelper.insert(postsFromNetwork[0].toMap());
      print("dbHelper.queryRowCount() is ${await dbHelper.queryRowCount()}");
    }
    resultList = await queryPostsFromDb(dbHelper);
  } catch (socketException) {
    print("SocketException ee  is ${socketException.toString()}");
    resultError = "SocketException ee  is ${socketException.toString()}";
    resultList = await queryPostsFromDb(dbHelper);
  }

  Pair result = Pair(resultList, resultError);
  return result;
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
