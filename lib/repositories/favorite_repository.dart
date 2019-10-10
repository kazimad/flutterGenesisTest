import 'dart:convert';

import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/data_classes/pair.dart';
import 'package:flutter_genesis_test/persistance/db_movie_helper.dart';
import 'package:flutter_genesis_test/ui/utils/commands.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Pair> queryAllFavoritesFromStorage() async {
  String error;
  List<MovieInner> queriedMovies;

  var sharedPreferences = await SharedPreferences.getInstance();
  var preferencesArray = sharedPreferences.getString(FAVORITE_KEY_NAME);
  if (isNotNullAndNotEmpty(preferencesArray)) {
    List<dynamic> favoriteList = json.decode(preferencesArray);
    queriedMovies = await queryMoviesFromDbById(DatabaseMovieHelper.instance, favoriteList);
  } else {
    error = "No Favorites";
  }
  Pair pairResult = Pair(queriedMovies, error);
  return Future<Pair>.value(pairResult);
}

Future<List<MovieInner>> queryMoviesFromDbById(DatabaseMovieHelper dbHelper, List<dynamic> favoritesList) async {
  List<MovieInner> movies = [];
  if (favoritesList != null && favoritesList.length > 0) {
    var queriedFavorites = await dbHelper.queryMoviesWithId(favoritesList);
    queriedFavorites.forEach((each) {
      print("myLog each $each");
      movies.add(MovieInner.fromDbJson(each));
    });
  }
  return Future<List<MovieInner>>.value(movies);
}
