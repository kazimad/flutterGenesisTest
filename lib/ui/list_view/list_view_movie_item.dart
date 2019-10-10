import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/favorite_block.dart';
import 'package:flutter_genesis_test/block/movie_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/ui/utils/commands.dart';

abstract class ListViewMovieItem {}

class HeaderItem extends Text implements ListViewMovieItem {
  final String headerText;

  HeaderItem(this.headerText) : super(headerText);
}

class RegularItem extends StatefulWidget implements ListViewMovieItem {
  final MovieInner movie;

  const RegularItem({this.movie});

  @override
  _RegularItemState createState() => _RegularItemState(movie: movie);
}

class _RegularItemState extends State<RegularItem> {
  final MovieInner movie;

  final double imageSize = 100;
  final double margin8 = 8;
  final double elevation = 4;
  final double minFontSize = 12;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(margin8),
                  child: Container(
                    width: imageSize,
                    height: imageSize,
                    child: CachedNetworkImage(
                      imageUrl: "http://via.placeholder.com/350x150",
                      placeholder: (context, url) => new CircularProgressIndicator(),
                      errorWidget: (context, url, error) => new Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Text(movie.popularity.toString()),
                  margin: EdgeInsets.only(left: (imageSize / 2), top: imageSize + (imageSize / 5)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: imageSize + (margin8 * 2), top: margin8),
                child: Column(
                  children: <Widget>[
//                    Text(movie.originalTitle),
                    Text(movie.id.toString() + " " + movie.isFavorite.toString()),
                    Text(movie.overview),
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
                              properText(movie),
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                              minFontSize: minFontSize,
                              maxLines: maxLines,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onPressed: () {
                              setState(() {
                                movie.isFavorite ? favoriteBloc.removeFromFavorites(movie.id) : favoriteBloc.addToFavorites(movie.id);
                                movie.isFavorite = !movie.isFavorite;
                                movieBloc.updateMovie(movie);
                                print("myLog movieBloc.updateMovie movie.id ${movie.id}");
                                favoriteBloc.getFavorites();
                              });
                            },
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: MaterialButton(
                            child: AutoSizeText(
                              "share".toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                              minFontSize: minFontSize,
                              maxLines: maxLines,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onPressed: () {
                              showErrorMessage(context, movie.voteCount.toString() + ' - ' + movie.title);
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
      ),
    );
  }

  final int maxLines = 1;

  _RegularItemState({this.movie});

  String properText(MovieInner movieInner) {
    if (movieInner.isFavorite) {
      return "Remove from favorite".toUpperCase();
    } else {
      return "Add  favorite".toUpperCase();
    }
  }
}
