import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/Post.dart';
import 'package:flutter_genesis_test/network/sources/FilmUrlSource.dart';
import 'package:flutter_genesis_test/ui/list_view/ListViewPosts.dart';
import 'package:flutter_genesis_test/ui/utils/Commands.dart';
import 'package:flutter_genesis_test/ui/utils/DatabaseHelper.dart';

class MyListView extends StatelessWidget {
  final List<Post> posts;
  final dbHelper = DatabaseHelper.instance;

  MyListView({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: fetchPosts(),
      builder: (context, snapshot) {
        if (!snapshot.hasError) {
          dbHelper.deleteAll();
          dbHelper.insert(snapshot.data[0].toMap());
//          Post.insertAllPosts(snapshot.data);
        } else {
          print(snapshot.error);
        }

        dbHelper.queryAllRows().then((value) {
          var proxyValue = value;
          var listPosts = List<Post>();
          proxyValue.forEach((nextProxyValue) => {
            // тут я хочу трансформировать то что пришло в лист постов что бы передать в список
          
            Post valueTotransform = Post.fromJson(nextProxyValue);
          });
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
