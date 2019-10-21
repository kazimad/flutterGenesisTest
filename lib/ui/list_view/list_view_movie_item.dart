import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/favorite_block.dart';
import 'package:flutter_genesis_test/block/movie_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/ui/movie_details_screen.dart';
import 'package:flutter_genesis_test/ui/utils/commands.dart';

abstract class ListViewMovieItem {}

class HeaderItem extends Text implements ListViewMovieItem {
  final String headerText;

  HeaderItem(this.headerText) : super(headerText);
}

class RegularItem extends StatefulWidget implements ListViewMovieItem {
  final MovieInner movie;

  const RegularItem({this.movie, Key key}) : super(key: key);

  @override
  _RegularItemState createState() => _RegularItemState(movie: movie);
}

class _RegularItemState extends State<RegularItem> {
  final MovieInner movie;

  final double imageSize = 100;
  final double margin8 = 8.0;
  final double elevation = 4;
  final double minFontSize = 6;
  final int maxLinesButton = 1;
  final int maxLinesText = 3;

  @override
  void initState() {
    super.initState();
    //TODO find out why it is doesnt called after new data in stream comes. In case when we switch to movies tab
    print("_RegularItemState is movie.id ${movie.id}, movie.isFavorite ${movie.isFavorite}");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
//                    margin: EdgeInsets.only(left: (imageSize / 2), top: imageSize + (imageSize / 5)),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(movie.id.toString() + " " + movie.isFavorite.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(movie.overview, maxLines: maxLinesText, overflow: TextOverflow.ellipsis),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
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
                                print("myLog movieBloc.updateMovie movie.id ${movie.id}");
//                                favoriteBloc.getFavorites();
                              });
                            },
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: MaterialButton(
                            child: AutoSizeText(
                              "share".toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                              minFontSize: minFontSize,
                              maxLines: maxLinesButton,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onPressed: () {
                              doShare(movie);
                              showErrorMessage(context, movie.voteCount.toString() + ' - ' + movie.title);
                            },
                          ),
                        )
                      ],
                    )
                  ],
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
