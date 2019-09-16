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
          if (snapshot.hasData) {
            dbHelper.deleteAll();
            print("MyListView snapshot.data is ${snapshot.data.length}");
            dbHelper.insert(snapshot.data[0].toMap());
//          Post.insertAllPosts(snapshot.data);
            dbHelper
                .queryAllRows()
                .then((value) => {print("dbHelper.queryAllRows() $value")});
          }
        } else {
          print(snapshot.error);
        }

        dbHelper.queryAllRows().then((value) {
          var proxyValue = value;
          var listPosts = List<Post>();
          Post valueToTransform;
          proxyValue.forEach((nextProxyValue) {
            valueToTransform = Post.fromJson(nextProxyValue);
            listPosts.add(valueToTransform);
          });
          return listPosts != null
              ? ListViewPosts(posts: listPosts)
              : Center(child: CircularProgressIndicator());
        }, onError: (error) {
          return Commands.showSnackBar(context, "error is ${error.toString()}");
        });
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
