import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/data_classes/pair.dart';
import 'package:flutter_genesis_test/data_classes/response/movie_parse_result.dart';
import 'package:flutter_genesis_test/network/provider/post_api_provider.dart';
import 'package:flutter_genesis_test/persistance/db_movie_helper.dart';
import 'package:flutter_genesis_test/ui/utils/commands.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';

class PostRepository {
  final PostApiProvider _apiProvider = PostApiProvider();
  final dbHelper = DatabaseMovieHelper.instance;
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
        listToInsert.add(MovieInner.fromMoviePOJO(each).toMap());
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

  Future<List<MovieInner>> queryPostsFromDb(
      DatabaseMovieHelper dbHelper) async {
    List<MovieInner> posts = [];
    var queriedList = await dbHelper.queryAllRows();
    print("queriedList is ${queriedList.length}");

    queriedList.forEach((element) {
      posts.add(MovieInner.fromDbJson(element));
    });
    print("posts is ${posts.length}");

    return Future<List<MovieInner>>.value(posts);
  }
}
