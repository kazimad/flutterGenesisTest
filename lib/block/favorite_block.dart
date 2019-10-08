import 'package:flutter_genesis_test/data_classes/pair.dart';
import 'package:flutter_genesis_test/persistance/sp_favorite_helper.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteBlock {
  final BehaviorSubject<Pair> _subject = BehaviorSubject<Pair>();

  getFavorites() async {
    Pair response = await getAllFavorites();
    _subject.sink.add(response);
  }

  addToFavorites(int id) {
    addToFavorite(id);
  }

  removeFromFavorite(int id) {
    removeFromFavorite(id);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<Pair> get subject => _subject;
}

final favoriteBloc = FavoriteBlock();
