import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/global_utils/pair.dart';
import 'package:flutter_genesis_test/repositories/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

final movieBloc = MovieBlock();

class MovieBlock {
  final _movieRepository = MovieRepository();
  final _subject = BehaviorSubject<Pair>();

  getMovies() async {
    Pair response = await _movieRepository.getMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  updateMovie(MovieInner innerMovie) {
    _movieRepository.updateMovie(innerMovie);
  }

  BehaviorSubject<Pair> get subject => _subject;
}
