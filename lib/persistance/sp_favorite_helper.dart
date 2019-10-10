import 'dart:convert';

import 'package:flutter_genesis_test/data_classes/pair.dart';
import 'package:flutter_genesis_test/repositories/favorite_repository.dart';
import 'package:flutter_genesis_test/ui/utils/commands.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// I know that there is not the best performance : to get them, to read, to decode and to write - but I just wanted to try work with shared preferences
addToFavorite(int value) async {
  await _workWithSharedPreferences(value, true);
}

removeFromFavorite(int value) async {
  await _workWithSharedPreferences(value, false);
}

Future _workWithSharedPreferences(int value, bool wouldWeAdd) async {
  var sharedPreferences = await SharedPreferences.getInstance();
  var preferencesArray = sharedPreferences.getString(FAVORITE_KEY_NAME);
  if (isNotNullAndNotEmpty(preferencesArray)) {
    List<dynamic> favoriteArray = json.decode(preferencesArray);
    if (wouldWeAdd) {
      if (!favoriteArray.contains(value)) {
        favoriteArray.add(value);
        saveSharedPrefs(favoriteArray, sharedPreferences);
      }
    } else {
      favoriteArray.remove(value);
      saveSharedPrefs(favoriteArray, sharedPreferences);
    }
  } else {
    var favoriteArray = <dynamic>[];
    favoriteArray.add(value);
    if (wouldWeAdd) {
      saveSharedPrefs(favoriteArray, sharedPreferences);
    }
  }
}

void saveSharedPrefs(List favoriteArray, SharedPreferences sharedPreferences) {
  var favoriteArrayJson = json.encode(favoriteArray);
  sharedPreferences.setString(FAVORITE_KEY_NAME, favoriteArrayJson);
}

Future<Pair> getAllFavorites() {
  return queryAllFavoritesFromStorage();
}

Future<List<dynamic>> getAllFavoriteIds(){
  return getFavoriteIdsList();
}
