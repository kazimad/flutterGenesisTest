import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/data_classes/pair.dart';
import 'package:flutter_genesis_test/data_classes/response/movie_parse_result.dart';
import 'package:flutter_genesis_test/network/provider/post_api_provider.dart';
import 'package:flutter_genesis_test/persistance/db_movie_helper.dart';
import 'package:flutter_genesis_test/persistance/sp_favorite_helper.dart';
import 'package:flutter_genesis_test/ui/utils/commands.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';

class MovieRepository {
  final MovieApiProvider _apiProvider = MovieApiProvider();
  final dbHelper = DatabaseMovieHelper.instance;
  String error;
  MovieParceResult response;

  Future<Pair> getMovies() async {
//    try {
    response = await _apiProvider.getMovies(API_KEY, API_SORT_BY, getCurrentTimeAndFormat(), getFutureTimeAndFormat());
//    } catch (responseError) {
//      this.error = handleError(responseError);
//    }
    if (response.topResponse != null) {
      await dbHelper.deleteAll();
      List<Map<String, dynamic>> listToInsert = [];
      // get all favorites to set favorite/ not favorite for newly loaded movies
      var allFavoritesIds = await getAllFavoriteIds();

      response.topResponse.movies.forEach((each) {
        var innerMovieItem = MovieInner.fromMoviePOJO(each);
        if (allFavoritesIds != null && allFavoritesIds.contains(innerMovieItem.id)) {
          innerMovieItem.isFavorite = true;
        }
        listToInsert.add(innerMovieItem.toMap());
      });
      await dbHelper.insertAll(listToInsert);
    } else {
      this.error = response.error;
    }

    var result = await queryMoviesFromDb(dbHelper);
    Pair pairResult = Pair(result, error);
    return Future<Pair>.value(pairResult);
  }

  Future<List<MovieInner>> queryMoviesFromDb(DatabaseMovieHelper dbHelper) async {
    List<MovieInner> movies = [];
    var queriedList = await dbHelper.queryAllRows();
    print("queriedList is ${queriedList.length}");

    queriedList.forEach((element) {
      movies.add(MovieInner.fromDbJson(element));
    });
    print("movies is ${movies.length}");

    return Future<List<MovieInner>>.value(movies);
  }

  void updateMovie(MovieInner movieInner) async {
    await dbHelper.update(movieInner.toMap());
  }
}