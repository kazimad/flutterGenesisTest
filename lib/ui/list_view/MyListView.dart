import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/Post.dart';
import 'package:flutter_genesis_test/network/sources/FilmUrlSource.dart';
import 'package:flutter_genesis_test/ui/list_view/ListViewPosts.dart';

class MyListView extends StatelessWidget {
  final List<Post> posts;

  MyListView({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: fetchPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? ListViewPosts(posts: snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
