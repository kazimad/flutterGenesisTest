import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/favorite_block.dart';
import 'package:flutter_genesis_test/block/movie_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/ui/movie_details_screen.dart';
import 'package:flutter_genesis_test/ui/utils/commands.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';

abstract class ListViewMovieItem {}

class HeaderItem extends Text implements ListViewMovieItem {
  final String headerText;

  HeaderItem(this.headerText) : super(headerText);
}

class RegularItem extends StatefulWidget implements ListViewMovieItem {
  final MovieInner movie;
  final SourceTab source;

  const RegularItem({this.movie, this.source, Key key}) : super(key: key);

  @override
  _RegularItemState createState() => _RegularItemState(movie: movie);
}

class _RegularItemState extends State<RegularItem> {
  final MovieInner movie;

  final double imageSize = 100;
  final double elevation = 4;
  final double minFontSize = 6;
  final int maxLinesButton = 1;
  final int maxLinesText = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          child: Card(
            elevation: 4,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
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
                            imageUrl: _validatePosterPath(movie),
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
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(top: margin8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(margin: EdgeInsets.only(top: margin8), child: Text(movie.title, style: TextStyle(fontWeight: FontWeight.bold))),
                        Container(
                            margin: EdgeInsets.only(top: margin8),
                            child: Text(movie.overview, maxLines: maxLinesText, overflow: TextOverflow.ellipsis)),
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
                                  properText(movie),
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                                  minFontSize: minFontSize,
                                  maxLines: maxLinesButton,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onPressed: () {
                                  setState(() {
                                    movie.isFavorite ? favoriteBloc.removeFromFavorites(movie.id) : favoriteBloc.addToFavorites(movie.id);
                                    movie.isFavorite = !movie.isFavorite;
                                    movieBloc.updateMovie(movie);
                                    if (widget.source == SourceTab.favorite) {
                                      favoriteBloc.getFavorites();
                                    }
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Builder(
                                builder: (ctx) => MaterialButton(
                                  child: AutoSizeText(
                                    "share".toUpperCase(),
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                                    minFontSize: minFontSize,
                                    maxLines: maxLinesButton,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onPressed: () {
                                    doShare(movie);
                                    showErrorMessage(ctx, movie.voteCount.toString() + ' - ' + movie.title);
                                  },
                                ),
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
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails(movieToDetail: movie)));
          },
        ),
      ),
    );
  }

  _RegularItemState({this.movie, key: "regular"});
}

String _validatePosterPath(MovieInner movie) {
  if (movie.posterPath != null) {
    return BASE_IMAGE_LINK + movie.posterPath;
  } else {
    return "";
  }
}

enum SourceTab { movies, favorite }
