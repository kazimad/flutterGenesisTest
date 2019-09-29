import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/post_block.dart';
import 'package:flutter_genesis_test/data_classes/movie_POJO.dart';
import 'package:flutter_genesis_test/data_classes/pair.dart';
import 'package:flutter_genesis_test/ui/list_view/list_view_posts.dart';
import 'package:flutter_genesis_test/ui/utils/commands.dart';

class PostView extends StatefulWidget {
  PostView({Key key}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  void initState() {
    super.initState();
    bloc.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Pair>(
      stream: bloc.subject.stream,
      builder: (context, AsyncSnapshot<Pair> snapshot) {
        if (snapshot.hasData) {
          if (isNotNullAndNotEmpty(snapshot.data.errorParam)) {
            // TODO why it shows 3 times ?
            showErrorMessage(context, snapshot.data.errorParam);
          }
          List<MoviePOJO> listPost = snapshot.data.expectedResult;
          return _buildPostWidget(listPost);
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
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildPostWidget(List<MoviePOJO> posts) {
    return ListViewPosts(posts: posts);
  }
}
