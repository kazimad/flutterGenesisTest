import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/favorite_block.dart';
import 'package:flutter_genesis_test/block/movie_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';
import 'package:flutter_genesis_test/ui/list_view_widgets/source_tab.dart';
import 'package:flutter_genesis_test/ui/utils/commands/commands_logic_and_interactions.dart';
import 'package:flutter_genesis_test/ui/utils/commands/commands_ui.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';

class DescriptionWidget extends StatefulWidget {
  final MovieInner movie;
  final SourceTab source;

  DescriptionWidget({this.movie, this.source});

  @override
  _DescriptionWidgetState createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
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
