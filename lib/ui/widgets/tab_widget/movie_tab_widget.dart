import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/movie_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';
import 'package:flutter_genesis_test/global_utils/pair.dart';
import 'package:flutter_genesis_test/ui/ui_utils/commands/commands_ui.dart';
import 'package:flutter_genesis_test/ui/widgets/error_widget.dart';
import 'package:flutter_genesis_test/ui/widgets/list_view_widgets/list_movies_widget.dart';
import 'package:flutter_genesis_test/ui/widgets/list_view_widgets/source_tab.dart';
import 'package:flutter_genesis_test/ui/widgets/loading_widget.dart';

class MovieTabWidget extends StatefulWidget {
  MovieTabWidget({Key key}) : super(key: key);

  @override
  _MovieTabWidgetState createState() => _MovieTabWidgetState();
}

class _MovieTabWidgetState extends State<MovieTabWidget> {
  @override
  void initState() {
    super.initState();
    movieBloc.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Pair>(
      stream: movieBloc.subject.stream,
      builder: (context, AsyncSnapshot<Pair> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.exception != null) {
            showErrorMessage(context, snapshot.data.exception);
          }
          List<MovieInner> listMovies = snapshot.data.data;
          if (listMovies != null && listMovies.length > 0) {
            return _buildListWidget(listMovies);
          } else {
            return MovieErrorWidget(S.of(context).no_movies_yet);
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
    return RefreshIndicator(
      child: ListViewMoviesWidget(movies: movies, source: SourceTab.movies),
      onRefresh: () => movieBloc.getMovies(),
    );
  }
}
