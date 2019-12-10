import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/favorite_block.dart';
import 'package:flutter_genesis_test/block/movie_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner_model.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';
import 'package:flutter_genesis_test/global_utils/share_utils.dart';
import 'package:flutter_genesis_test/ui/ui_utils/commands/commands_ui.dart';

class DetailDescriptionWidget extends StatefulWidget {
  final MovieInnerModel movieToDetail;

  DetailDescriptionWidget({@required this.movieToDetail});

  @override
  _DetailDescriptionWidgetState createState() => _DetailDescriptionWidgetState();
}

class _DetailDescriptionWidgetState extends State<DetailDescriptionWidget> {
  final double minFontSize = 12;
  final int maxLinesButton = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(margin: EdgeInsets.only(top: 8), child: Text(widget.movieToDetail.title, style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
              child: Padding(
            padding: EdgeInsets.all(8),
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
                    validateTextAddOrRemove(widget.movieToDetail, context),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    minFontSize: minFontSize,
                    maxLines: maxLinesButton,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onPressed: () {
                    _onAddToFavoriteClick();
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

  void _onAddToFavoriteClick() {
    setState(() {
      widget.movieToDetail.isFavorite
          ? favoriteBloc.removeFromFavorites(widget.movieToDetail.id)
          : favoriteBloc.addToFavorites(widget.movieToDetail.id);
      widget.movieToDetail.isFavorite = !widget.movieToDetail.isFavorite;
      movieBloc.updateMovie(widget.movieToDetail);
    });
  }
}
