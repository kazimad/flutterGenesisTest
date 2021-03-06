import 'package:flutter_genesis_test/data_classes/movie_inner_model.dart';
import 'package:flutter_genesis_test/data_classes/response/movie_parse_result.dart';
import 'package:flutter_genesis_test/global_utils/pair.dart';
import 'package:flutter_genesis_test/global_utils/time_and_data_utils.dart';
import 'package:flutter_genesis_test/network/provider/post_api_provider.dart';
import 'package:flutter_genesis_test/persistence/db_movie_helper.dart';
import 'package:flutter_genesis_test/persistence/sp_favorite_helper.dart';
import 'package:flutter_genesis_test/ui/ui_utils/constants.dart';

class MovieRepository {
  final MovieApiProvider _apiProvider = MovieApiProvider();
  final dbHelper = DatabaseMovieHelper.instance;
  Exception exception;
  MovieParceResult response;

  Future<Pair> getMovies() async {
    try {
      response = await _apiProvider.getMovies(API_KEY, API_SORT_BY, getCurrentTimeAndFormat(), getFutureTimeAndFormat());
    } catch (responseError) {
      this.exception = responseError;
    }
    if (response.topResponse != null) {
      await dbHelper.deleteAll();
      List<Map<String, dynamic>> listToInsert = [];
      // get all favorites to set favorite/ not favorite for newly loaded movies
      var allFavoritesIds = await getAllFavoriteIds();

      response.topResponse.movies.forEach((each) {
        var innerMovieItem = MovieInnerModel.fromMoviePOJO(each);
        if (allFavoritesIds != null && allFavoritesIds.contains(innerMovieItem.id)) {
          innerMovieItem.isFavorite = true;
        }
        listToInsert.add(innerMovieItem.toMap());
      });
      await dbHelper.insertAll(listToInsert);
    } else {
      this.exception = response.error;
    }

    var result = await queryMoviesFromDb(dbHelper);
    Pair pairResult = Pair(result, exception);
    return Future<Pair>.value(pairResult);
  }

  Future<List<MovieInnerModel>> queryMoviesFromDb(DatabaseMovieHelper dbHelper) async {
    List<MovieInnerModel> movies = [];
    var queriedList = await dbHelper.queryAllRows();
    queriedList.forEach((element) {
      movies.add(MovieInnerModel.fromJson(element));
    });
    return Future<List<MovieInnerModel>>.value(movies);
  }

  void updateMovie(MovieInnerModel movieInner) async {
    await dbHelper.update(movieInner.toMap());
  }
}
