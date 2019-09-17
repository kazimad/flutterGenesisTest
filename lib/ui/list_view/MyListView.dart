import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/Pair.dart';
import 'package:flutter_genesis_test/data_classes/Post.dart';
import 'package:flutter_genesis_test/repositories/PostRepository.dart';
import 'package:flutter_genesis_test/ui/list_view/ListViewPosts.dart';
import 'package:flutter_genesis_test/ui/utils/DatabaseHelper.dart';

class MyListView extends StatelessWidget {
  final List<Post> posts;
  final dbHelper = DatabaseHelper.instance;

  MyListView({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pair>(
      future: getPosts(),
      builder: (context, snapshot) {
// TODO find out why it doesn't work
        //        if (snapshot.data != null) {
//          if (isNotNullAndNotEmpty(snapshot.data.errorParam)) {
//            showErrorMessage(context, snapshot.data.errorParam);
//          }
//        }

        return (snapshot.data != null && snapshot.data.expectedResult != null)
            ? ListViewPosts(posts: snapshot.data.expectedResult)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
