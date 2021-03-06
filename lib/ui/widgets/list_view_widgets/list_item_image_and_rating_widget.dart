import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner_model.dart';
import 'package:flutter_genesis_test/network/network_commands/commands_network.dart';
import 'package:flutter_genesis_test/ui/ui_utils/constants.dart';

class ListItemImageAndRatingWidget extends StatelessWidget {
  final MovieInnerModel movie;
  final double imageSize = 100;

  ListItemImageAndRatingWidget({this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 8, left: 8, bottom: 8),
          child: Hero(
            tag: HERO_BASE_KEY + movie.id.toString(),
            child: Container(
              width: imageSize,
              height: imageSize,
              child: CachedNetworkImage(
                imageUrl: aliasPosterPath(movie),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
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
