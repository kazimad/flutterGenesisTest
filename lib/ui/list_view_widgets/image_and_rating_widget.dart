import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/ui/utils/commands/commands_api.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';

class ImageAndRatingWidget extends StatelessWidget {
  final MovieInner movie;
  final double imageSize = 100;

  ImageAndRatingWidget({this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: margin8, left: margin8, bottom: margin8),
          child: Hero(
            tag: HERO_BASE_KEY + movie.id.toString(),
            child: Container(
              width: imageSize,
              height: imageSize,
              child: CachedNetworkImage(
                imageUrl: validatePosterPath(movie),
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
          ),
        ),
        Container(
          child: Text(movie.popularity.toString()),
        ),
      ],
    );
  }
}
