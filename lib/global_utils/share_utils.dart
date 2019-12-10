import 'package:flutter_genesis_test/data_classes/movie_inner_model.dart';
import 'package:share/share.dart';

void doShare(MovieInnerModel movieToShare) {
  Share.share("movie's id is ${movieToShare.id}, title is ${movieToShare.title}, overview is ${movieToShare.overview}");
}