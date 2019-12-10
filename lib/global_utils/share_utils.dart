import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:share/share.dart';

void doShare(MovieInner movieToShare) {
  Share.share("movie's id is ${movieToShare.id}, title is ${movieToShare.title}, overview is ${movieToShare.overview}");
}