import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/Post.dart';
import 'package:flutter_genesis_test/network/sources/FilmUrlSource.dart';
import 'package:flutter_genesis_test/ui/list_view/ListViewPosts.dart';
import 'package:flutter_genesis_test/ui/utils/Commands.dart';

class MyListView extends StatelessWidget {
  final List<Post> posts;

  MyListView({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: fetchPosts(),
      builder: (context, snapshot) {
        if (!snapshot.hasError) {
          Post.deleteAllInTable();
          Post.insertAllPosts(snapshot.data);
        } else {
          print(snapshot.error);
        }

        Post.getPosts().then((value) {
          return value != null
              ? ListViewPosts(posts: value)
              : Center(child: CircularProgressIndicator());
        }, onError: (error) {
          return Commands.showSnackBar(context, "error is ${error.toString()}");
        });
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
