
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/favorite_block.dart';
import 'package:flutter_genesis_test/block/movie_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';
import 'package:flutter_genesis_test/ui/utils/commands/commands_api.dart';
import 'package:flutter_genesis_test/ui/utils/commands/commands_logic_and_interactions.dart';
import 'package:flutter_genesis_test/ui/utils/commands/commands_ui.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';

class MovieDetails extends StatelessWidget {
  final MovieInner movieToDetail;

  const MovieDetails({this.movieToDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MovieImage(movieToDetail: movieToDetail),
              MovieDescription(movieToDetail: movieToDetail),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieImage extends StatelessWidget {
  final double imageSize = 200;
  final MovieInner movieToDetail;

  MovieImage({@required this.movieToDetail});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right:  8, left:  8, bottom:  8),
          child: Hero(
            tag: HERO_BASE_KEY + movieToDetail.id.toString(),
            child: Container(
              width: imageSize,
              height: imageSize,
              child: Container(
                margin: EdgeInsets.only(top:  8),
                child: CachedNetworkImage(
                  imageUrl: aliasPosterPath(movieToDetail),
                  placeholder: (context, url) =>   CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>   Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MovieDescription extends StatefulWidget {
  final MovieInner movieToDetail;

  MovieDescription({@required this.movieToDetail});

  @override
  _MovieDescriptionState createState() => _MovieDescriptionState();
}

class _MovieDescriptionState extends State<MovieDescription> {
  final double minFontSize = 12;

  final int maxLinesButton = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:  8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(margin: EdgeInsets.only(top:  8), child: Text(widget.movieToDetail.title, style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
              child: Padding(
            padding: EdgeInsets.all( 8),
            child: Text(widget.movieToDetail.overview),
          )),
          Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: MaterialButton(
                  child: AutoSizeText(
                    properText(widget.movieToDetail, context),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    minFontSize: minFontSize,
                    maxLines: maxLinesButton,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.movieToDetail.isFavorite
                          ? favoriteBloc.removeFromFavorites(widget.movieToDetail.id)
                          : favoriteBloc.addToFavorites(widget.movieToDetail.id);
                      widget.movieToDetail.isFavorite = !widget.movieToDetail.isFavorite;
                      movieBloc.updateMovie(widget.movieToDetail);
                    });
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: MaterialButton(
                  child: AutoSizeText(
                    S.of(context).share.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    minFontSize: minFontSize,
                    maxLines: maxLinesButton,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onPressed: () {
                    doShare(widget.movieToDetail);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
