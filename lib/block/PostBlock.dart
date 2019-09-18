import 'package:flutter_genesis_test/network/response/PostResponse.dart';
import 'package:flutter_genesis_test/repositories/PostRepository.dart';
import 'package:rxdart/rxdart.dart';

class PostBlock{
  final PostRepository _repository = PostRepository();
  final BehaviorSubject<PostResponse> _subject =
  BehaviorSubject<PostResponse>();

  getUser() async {
    PostResponse response = await _repository.getUser();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PostResponse> get subject => _subject;
}
final bloc = PostBlock();
