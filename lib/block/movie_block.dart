import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/data_classes/pair.dart';
import 'package:flutter_genesis_test/repositories/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBlock {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<Pair> _subject = BehaviorSubject<Pair>();

  getMovies() async {
    Pair response = await _repository.getMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  updateMovie(MovieInner innerMovie) {
   _repository.updateMovie(innerMovie);
  }
  BehaviorSubject<Pair> get subject => _subject;
}

final movieBloc = MovieBlock();
