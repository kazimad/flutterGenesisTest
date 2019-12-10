
import 'package:flutter_genesis_test/data_classes/movie_inner_model.dart';
import 'package:flutter_genesis_test/ui/ui_utils/constants.dart';

String aliasPosterPath(MovieInnerModel movie) {
  if (movie.posterPath != null) {
    return BASE_IMAGE_LINK + movie.posterPath;
  } else {
    return "";
  }
}
