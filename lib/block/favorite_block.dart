import 'package:flutter_genesis_test/data_classes/pair.dart';
import 'package:flutter_genesis_test/persistance/sp_favorite_helper.dart' as helper;
import 'package:rxdart/rxdart.dart';

class FavoriteBlock {
  final BehaviorSubject<Pair> _subject = BehaviorSubject<Pair>();

  getFavorites() async {
    Pair response = await helper.getAllFavorites();
    _subject.sink.add(response);
  }

  addToFavorites(int id) {
    helper.addToFavorite(id);
  }

  removeFromFavorites(int id) {
    helper.removeFromFavorite(id);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<Pair> get subject => _subject;
}

final favoriteBloc = FavoriteBlock();
