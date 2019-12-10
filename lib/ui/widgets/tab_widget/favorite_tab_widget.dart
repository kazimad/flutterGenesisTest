import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/favorite_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';
import 'package:flutter_genesis_test/global_utils/pair.dart';
import 'package:flutter_genesis_test/ui/ui_utils/commands/commands_ui.dart';
import 'package:flutter_genesis_test/ui/widgets/error_widget.dart';
import 'package:flutter_genesis_test/ui/widgets/list_view_widgets/list_movies_widget.dart';
import 'package:flutter_genesis_test/ui/widgets/list_view_widgets/source_tab.dart';
import 'package:flutter_genesis_test/ui/widgets/loading_widget.dart';

class FavoriteTabWidget extends StatefulWidget {
  FavoriteTabWidget({Key key}) : super(key: key);

  @override
  FavoriteState createState() => FavoriteState();
}

class FavoriteState extends State<FavoriteTabWidget> {
  @override
  void initState() {
    super.initState();
    favoriteBloc.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Pair>(
      stream: favoriteBloc.subject.stream,
      builder: (context, AsyncSnapshot<Pair> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.exception != null) {
            showErrorMessage(context, snapshot.data.exception);
          }
          List<MovieInner> listFavorites = snapshot.data.data;
          if (listFavorites != null && listFavorites.length > 0) {
            return _buildListWidget(listFavorites);
          } else {
            return MovieErrorWidget(S.of(context).no_favorites_yet);
          }
        } else if (snapshot.hasError) {
          return MovieErrorWidget(snapshot.error.toString());
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildListWidget(List<MovieInner> movies) {
    return ListViewMoviesWidget(movies: movies, source: SourceTab.favorite);
  }
}
