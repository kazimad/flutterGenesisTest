import 'package:flutter_genesis_test/global_utils/pair.dart';
import 'package:flutter_genesis_test/persistence/sp_favorite_helper.dart' as favorite_helper;
import 'package:rxdart/rxdart.dart';

final favoriteBloc = FavoriteBlock();

class FavoriteBlock {
  final BehaviorSubject<Pair> _subject = BehaviorSubject<Pair>();

  getFavorites() async {
    Pair response = await favorite_helper.getAllFavorites();
    _subject.sink.add(response);
  }

  addToFavorites(int id) {
    favorite_helper.addToFavorite(id);
  }

  removeFromFavorites(int id) {
    favorite_helper.removeFromFavorite(id);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<Pair> get subject => _subject;
}
