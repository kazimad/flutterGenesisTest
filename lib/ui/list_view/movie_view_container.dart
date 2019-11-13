import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/movie_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/data_classes/pair.dart';
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
    print("myLog movie_list_view_container initState() ");
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
            return _buildErrorWidget("No Movies yet");
          }
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Loading data from API..."), CircularProgressIndicator()],
        ));
  }


  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$error"),
      ],
    ));
  }


//  Widget _buildErrorWidget(String error) {
//    return RefreshIndicator(
//      child: Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              Text("$error"),
//            ],
//          )),
//      onRefresh: movieBloc.getMovies(),
//    );
//  }

//  Widget _buildListWidget(List<MovieInner> movies) {
//    return ListViewMovies(movies: movies, key: UniqueKey());
//  }

  Widget _buildListWidget(List<MovieInner> movies) {
    return RefreshIndicator(
      child: ListViewMovies(movies: movies, key: UniqueKey()),
      onRefresh: ()=>movieBloc.getMovies(),
    );
  }
}
