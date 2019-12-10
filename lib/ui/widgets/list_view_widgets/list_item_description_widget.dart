import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/favorite_block.dart';
import 'package:flutter_genesis_test/block/movie_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';
import 'package:flutter_genesis_test/global_utils/share_utils.dart';
import 'package:flutter_genesis_test/ui/ui_utils/commands/commands_ui.dart';
import 'package:flutter_genesis_test/ui/ui_utils/constants.dart';
import 'package:flutter_genesis_test/ui/widgets/list_view_widgets/source_tab.dart';

class ListItemDescriptionWidget extends StatefulWidget {
  final MovieInner movie;
  final SourceTab source;

  ListItemDescriptionWidget({this.movie, this.source});

  @override
  _ListItemDescriptionWidgetState createState() => _ListItemDescriptionWidgetState();
}

class _ListItemDescriptionWidgetState extends State<ListItemDescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(margin: EdgeInsets.only(top: 8), child: Text(widget.movie.title, style: TextStyle(fontWeight: FontWeight.bold))),
            Container(
                margin: EdgeInsets.only(top: 8),
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
                    child: AutoSizeText(
                      validateTextAddOrRemove(widget.movie, context),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      minFontSize: movieCardMinFontSize,
                      maxLines: movieCardMaxLinesButton,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      _onAddToFavoriteClick();
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

  void _onAddToFavoriteClick() {
    setState(() {
      widget.movie.isFavorite ? favoriteBloc.removeFromFavorites(widget.movie.id) : favoriteBloc.addToFavorites(widget.movie.id);
      widget.movie.isFavorite = !widget.movie.isFavorite;
      movieBloc.updateMovie(widget.movie);
      if (widget.source == SourceTab.favorite) {
        favoriteBloc.getFavorites();
      }
    });
  }
}
