import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/movie_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/data_classes/pair.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';
import 'package:flutter_genesis_test/ui/list_view/list_view_movie_item.dart';
import 'package:flutter_genesis_test/ui/list_view/list_view_movies.dart';
import 'package:flutter_genesis_test/ui/utils/commands.dart';

class MovieView extends StatefulWidget {
  MovieView({Key key}) : super(key: key);

  @override
  _MovieViewState createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
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
          if (isNotNullAndNotEmpty(snapshot.data.errorParam)) {
            showErrorMessage(context, snapshot.data.errorParam);
          }
          List<MovieInner> listMovies = snapshot.data.expectedResult;
          if (listMovies != null && listMovies.length > 0) {
            return _buildListWidget(listMovies);
          } else {
            return buildErrorWidget(S.of(context).no_movies_yet);
          }
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildListWidget(List<MovieInner> movies) {
    return RefreshIndicator(
      child: ListViewMovies(movies: movies, source: SourceTab.movies, key: UniqueKey()),
      onRefresh: () => movieBloc.getMovies(),
    );
  }
}
