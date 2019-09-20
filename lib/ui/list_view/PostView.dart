import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/block/PostBlock.dart';
import 'package:flutter_genesis_test/data_classes/Pair.dart';
import 'package:flutter_genesis_test/data_classes/Post.dart';
import 'package:flutter_genesis_test/db/DatabaseHelper.dart';
import 'package:flutter_genesis_test/ui/list_view/ListViewPosts.dart';
import 'package:flutter_genesis_test/ui/utils/Commands.dart';

class PostView extends StatefulWidget {
  PostView({Key key}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final dbHelper = DatabaseHelper.instance;

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
            return _buildErrorWidget(snapshot.data.errorParam);
          }
          return _buildPostWidget(snapshot.data.expectedResult);
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

  Widget _buildPostWidget(List<Post> posts) {
    return ListViewPosts(posts: posts);
  }
}
