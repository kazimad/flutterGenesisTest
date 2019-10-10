import 'package:flutter_genesis_test/data_classes/pair.dart';
import 'package:flutter_genesis_test/repositories/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

class PostBlock {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<Pair> _subject = BehaviorSubject<Pair>();

  getPosts() async {
    Pair response = await _repository.getMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  updateMovie(){
    // TODO add save updated movie is favorite
  }
  BehaviorSubject<Pair> get subject => _subject;
}

final movieBloc = PostBlock();
