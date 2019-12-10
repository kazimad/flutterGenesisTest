import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner_model.dart';
import 'package:flutter_genesis_test/network/network_commands/commands_network.dart';
import 'package:flutter_genesis_test/ui/ui_utils/constants.dart';

class DetailImageWidget extends StatelessWidget {
  final double imageSize = 200;
  final MovieInnerModel movieToDetail;

  DetailImageWidget({@required this.movieToDetail});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 8, left: 8, bottom: 8),
          child: Hero(
            tag: HERO_BASE_KEY + movieToDetail.id.toString(),
            child: Container(
              width: imageSize,
              height: imageSize,
              child: Container(
                margin: EdgeInsets.only(top: 8),
                child: CachedNetworkImage(
                  imageUrl: aliasPosterPath(movieToDetail),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
