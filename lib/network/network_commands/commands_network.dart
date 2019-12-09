
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/ui/ui_utils/constants.dart';

String aliasPosterPath(MovieInner movie) {
  if (movie.posterPath != null) {
    return BASE_IMAGE_LINK + movie.posterPath;
  } else {
    return "";
  }
}
