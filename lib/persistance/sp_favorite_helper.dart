import 'dart:convert';

import 'package:flutter_genesis_test/ui/utils/commands.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
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
      List<int> favoriteArray = json.decode(preferencesArray);
      if (!favoriteArray.contains(value)) {
        if (wouldWeAdd) {
          favoriteArray.add(value);
        } else {
          favoriteArray.remove(value);
        }
      }
      var favoriteArrayJson = json.encode(favoriteArray);
      sharedPreferences.setString(FAVORITE_KEY_NAME, favoriteArrayJson);
    } else {
      var favoriteArray = <int>[];
      favoriteArray.add(value);
      if (wouldWeAdd) {
        var favoriteArrayJson = json.encode(favoriteArray);
        sharedPreferences.setString(FAVORITE_KEY_NAME, favoriteArrayJson);
      }
    }
  }
}
