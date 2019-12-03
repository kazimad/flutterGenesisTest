import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/favorite_block.dart';
import 'package:flutter_genesis_test/block/movie_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';
import 'package:flutter_genesis_test/ui/utils/commands.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';

class MovieDetails extends StatefulWidget {
  final MovieInner movieToDetail;

  const MovieDetails({this.movieToDetail});

  @override
  _State createState() => _State();
}

class _State extends State<MovieDetails> {
  final double imageSize = 200;
  final double minFontSize = 12;
  final int maxLinesButton = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: margin8, left: margin8, bottom: margin8),
                  child: Hero(
                    tag: HERO_BASE_KEY + widget.movieToDetail.id.toString(),
                    child: Container(
                      width: imageSize,
                      height: imageSize,
                      child: Container(
                        margin: EdgeInsets.only(top: margin8),
                        child: CachedNetworkImage(
                          imageUrl: BASE_IMAGE_LINK + widget.movieToDetail.posterPath,
                          placeholder: (context, url) => new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(top: margin8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: margin8),
                        child: Text(widget.movieToDetail.title, style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                        child: Padding(
                      padding: EdgeInsets.all(margin8),
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
                            padding: EdgeInsets.only(left: 0),
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
                              showErrorMessage(context, widget.movieToDetail.voteCount.toString() + ' - ' + widget.movieToDetail.title);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
