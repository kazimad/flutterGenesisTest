import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/favorite_block.dart';
import 'package:flutter_genesis_test/block/movie_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/ui/utils/commands.dart';

class MovieDetails extends StatefulWidget {
  final MovieInner movieToDetail;

  const MovieDetails({this.movieToDetail});

  @override
  _State createState() => _State();
}

class _State extends State<MovieDetails> {
  final double imageSize = 200;
  final double margin8 = 8;
  final double minFontSize = 12;

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
            Container(
              width: imageSize,
              height: imageSize,
              child: CachedNetworkImage(
                imageUrl: "http://via.placeholder.com/350x150",
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
            Container(
              child: Text(widget.movieToDetail.popularity.toString()),
            ),
            Container(
              child: Column(
                children: <Widget>[
//                    Text(movie.originalTitle),
                  Text(widget.movieToDetail.id.toString() +
                      " " +
                      widget.movieToDetail.isFavorite.toString()),
                  Text(widget.movieToDetail.overview),
                  Divider(
                    color: Colors.grey,
                  ),
                  // TODO change to FlexBox

                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: MaterialButton(
                          child: AutoSizeText(
                            properText(widget.movieToDetail),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            minFontSize: minFontSize,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.movieToDetail.isFavorite
                                  ? favoriteBloc.removeFromFavorites(
                                      widget.movieToDetail.id)
                                  : favoriteBloc
                                      .addToFavorites(widget.movieToDetail.id);
                              widget.movieToDetail.isFavorite =
                                  !widget.movieToDetail.isFavorite;
                              movieBloc.updateMovie(widget.movieToDetail);
                              print(
                                  "myLog movieBloc.updateMovie movie.id ${widget.movieToDetail.id}");
//                                favoriteBloc.getFavorites();
                            });
                          },
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: MaterialButton(
                          child: AutoSizeText(
                            "share".toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            minFontSize: minFontSize,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onPressed: () {
                            doShare(widget.movieToDetail);
                            showErrorMessage(
                                context,
                                widget.movieToDetail.voteCount.toString() +
                                    ' - ' +
                                    widget.movieToDetail.title);
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
