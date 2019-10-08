import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/favorite_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/data_classes/pair.dart';
import 'package:flutter_genesis_test/ui/list_view/list_view_movies.dart';
import 'package:flutter_genesis_test/ui/utils/commands.dart';

class FavoriteView extends StatefulWidget {
  FavoriteView({Key key}) : super(key: key);

  @override
  FavoriteState createState() => FavoriteState();
}

class FavoriteState extends State<FavoriteView> {
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
          if (isNotNullAndNotEmpty(snapshot.data.errorParam)) {
            // TODO why it shows 3 times ?
            showErrorMessage(context, snapshot.data.errorParam);
          }
          List<MovieInner> listPost = snapshot.data.expectedResult;
          if (listPost != null && listPost.length > 0) {
            return _buildListWidget(listPost);
          } else {
            return _buildErrorWidget("No Favorites yet");
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

  Widget _buildListWidget(List<MovieInner> posts) {
    return ListViewMovies(posts: posts);
  }
}
