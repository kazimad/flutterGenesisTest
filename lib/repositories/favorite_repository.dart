import 'dart:convert';

import 'package:flutter_genesis_test/data_classes/movie_inner_model.dart';
import 'package:flutter_genesis_test/global_utils/pair.dart';
import 'package:flutter_genesis_test/exception/custom_exception.dart';
import 'package:flutter_genesis_test/persistence/db_movie_helper.dart';
import 'package:flutter_genesis_test/ui/ui_utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Pair> queryAllFavoritesFromStorage() async {
  Exception error;
  List<MovieInnerModel> queriedMovies;
  List<dynamic> favoriteIdList = await getFavoriteIdsList();
  if (favoriteIdList != null && favoriteIdList.length > 0) {
    queriedMovies = await queryMoviesFromDbById(DatabaseMovieHelper.instance, favoriteIdList);
  } else {
    error = CustomException("No Favorites");
  }

  Pair pairResult = Pair(queriedMovies, error);
  return Future<Pair>.value(pairResult);
}

Future<List<dynamic>> getFavoriteIdsList() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  var preferencesString = sharedPreferences.getString(FAVORITE_KEY_NAME);

  return preferencesString != null ? json.decode(preferencesString) : null;
}

Future<List<MovieInnerModel>> queryMoviesFromDbById(DatabaseMovieHelper dbHelper, List<dynamic> favoritesList) async {
  List<MovieInnerModel> movies = [];
  if (favoritesList != null && favoritesList.length > 0) {
    var queriedFavorites = await dbHelper.queryMoviesWithId(favoritesList);
    queriedFavorites.forEach((each) {
      movies.add(MovieInnerModel.fromJson(each));
    });
  }
  return Future<List<MovieInnerModel>>.value(movies);
}
