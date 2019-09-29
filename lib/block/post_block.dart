import 'package:flutter_genesis_test/data_classes/pair.dart';
import 'package:flutter_genesis_test/repositories/post_repository.dart';
import 'package:rxdart/rxdart.dart';

class PostBlock {
  final PostRepository _repository = PostRepository();
  final BehaviorSubject<Pair> _subject = BehaviorSubject<Pair>();

  getPosts() async {
    Pair response = await _repository.getUser();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<Pair> get subject => _subject;
}

final bloc = PostBlock();