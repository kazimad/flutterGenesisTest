import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/favorite_block.dart';
import 'package:flutter_genesis_test/block/movie_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/exception/custom_exception.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';
import 'package:flutter_genesis_test/ui/movie_details_screen.dart';
import 'package:flutter_genesis_test/ui/utils/commands/commands_api.dart';
import 'package:flutter_genesis_test/ui/utils/commands/commands_logic_and_interactions.dart';
import 'package:flutter_genesis_test/ui/utils/commands/commands_ui.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';

abstract class ListViewMovieItem {}

class HeaderItem extends Text implements ListViewMovieItem {
  final String headerText;

  HeaderItem(this.headerText) : super(headerText);
}

class RegularItem extends StatelessWidget implements ListViewMovieItem {
  final MovieInner movie;
  final SourceTab source;

  const RegularItem({this.movie, this.source, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(margin8),
        child: GestureDetector(
          child: Card(
            elevation: movieCardElevation,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ImageAndRating(
                  movie: movie,
                ),
                Description(
                  movie: movie,
                  source: source,
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
}

class ImageAndRating extends StatelessWidget {
  final MovieInner movie;
  final double imageSize = 100;

  ImageAndRating({this.movie});

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

class Description extends StatefulWidget {
  final MovieInner movie;
  final SourceTab source;

  Description({this.movie, this.source});

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(top: margin8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(margin: EdgeInsets.only(top: margin8), child: Text(widget.movie.title, style: TextStyle(fontWeight: FontWeight.bold))),
            Container(
                margin: EdgeInsets.only(top: margin8),
                child: Text(widget.movie.overview, maxLines: movieCardMaxLinesText, overflow: TextOverflow.ellipsis)),
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
                      properText(widget.movie, context),
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      minFontSize: movieCardMinFontSize,
                      maxLines: movieCardMaxLinesButton,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.movie.isFavorite ? favoriteBloc.removeFromFavorites(widget.movie.id) : favoriteBloc.addToFavorites(widget.movie.id);
                        widget.movie.isFavorite = !widget.movie.isFavorite;
                        movieBloc.updateMovie(widget.movie);
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
                        S.of(context).share.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                        minFontSize: movieCardMinFontSize,
                        maxLines: movieCardMaxLinesButton,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onPressed: () {
                        doShare(widget.movie);
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

enum SourceTab { movies, favorite }
