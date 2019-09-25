import 'package:flutter_genesis_test/data_classes/MoviePOJO.dart';
import 'package:flutter_genesis_test/data_classes/Pair.dart';
import 'package:flutter_genesis_test/data_classes/response/MovieParseResult.dart';
import 'package:flutter_genesis_test/db/DatabaseHelper.dart';
import 'package:flutter_genesis_test/network/provider/PostApiProvider.dart';
import 'package:flutter_genesis_test/ui/utils/Commands.dart';
import 'package:flutter_genesis_test/ui/utils/Constants.dart';

class PostRepository {
  final PostApiProvider _apiProvider = PostApiProvider();
  final dbHelper = DatabaseHelper.instance;
  String error;
  MovieParceResult response;

  Future<Pair> getUser() async {
//    try {
    response = await _apiProvider.getPosts(API_KEY, API_SORT_BY,
        getCurrentTimeAndFormat(), getFutureTimeAndFormat());
//    } catch (responseError) {
//      this.error = handleError(responseError);
//    }
    if (response.topResponse != null) {
      await dbHelper.deleteAll();

      List<Map<String, dynamic>> listToInsert = List<Map<String, dynamic>>();
      response.topResponse.movies.forEach((each) {
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

  Future<List<MoviePOJO>> queryPostsFromDb(DatabaseHelper dbHelper) async {
    List<MoviePOJO> posts = new List();
    var queriedList = await dbHelper.queryAllRows();
    print("queriedList is ${queriedList.length}");

    queriedList.forEach((element) {
      posts.add(MoviePOJO.fromJson(element));
    });
    print("posts is ${posts.length}");

    return Future<List<MoviePOJO>>.value(posts);
  }
}
