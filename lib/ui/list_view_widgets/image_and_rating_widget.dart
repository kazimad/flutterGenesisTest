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
          padding: EdgeInsets.only(right:  8, left:  8, bottom:  8),
          child: Hero(
            tag: HERO_BASE_KEY + movie.id.toString(),
            child: Container(
              width: imageSize,
              height: imageSize,
              child: CachedNetworkImage(
                imageUrl: aliasPosterPath(movie),
                placeholder: (context, url) =>   CircularProgressIndicator(),
                errorWidget: (context, url, error) =>   Icon(Icons.error),
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
