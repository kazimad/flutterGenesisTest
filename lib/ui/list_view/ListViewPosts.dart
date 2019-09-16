import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/Post.dart';
import 'package:flutter_genesis_test/ui/list_view/ListViewItem.dart';

class ListViewPosts extends StatelessWidget {
  final List<Post> posts;

  ListViewPosts({this.posts});

  @override
  Widget build(BuildContext context) {
    print("ListViewPosts Widget build ");
    return Container(
      child: ListView.builder(
          itemCount: posts.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return checkRegularOrHeader(position, posts);
          }),
    );
  }
}

checkRegularOrHeader(int index, List<Post> data) {
  print("ListViewPosts data ${data.length}");
//  if (index % 3 == 0) {
  return Container(
    child: RegularItem(post: (data[index])),
  );
//  }
//  else {
//    return Container(
//      child: HeaderItem(index.toString()),
//    );
//  }
}
