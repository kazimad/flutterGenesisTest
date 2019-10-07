import 'package:flutter_genesis_test/data_classes/pair.dart';
import 'package:flutter_genesis_test/repositories/favorite_repository.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteBlock {
  final BehaviorSubject<Pair> _subject = BehaviorSubject<Pair>();

  getFavorites() async {
    Pair response = await getAllFavorite();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<Pair> get subject => _subject;
}
final bloc = FavoriteBlock();
