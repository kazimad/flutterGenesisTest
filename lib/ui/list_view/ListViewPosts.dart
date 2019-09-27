import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/movie_POJO.dart';
import 'package:flutter_genesis_test/ui/list_view/ListViewItem.dart';
import 'package:flutter_genesis_test/ui/utils/Constants.dart';
import 'package:intl/intl.dart';


class ListViewPosts extends StatelessWidget {
  final List<MoviePOJO> posts;

  ListViewPosts({this.posts});

  @override
  Widget build(BuildContext context) {
//    print("ListViewPosts Widget build posts.length is ${posts.length}");
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

checkRegularOrHeader(int index, List<MoviePOJO> data) {
  print("ListViewPosts data ${data.length}");

  var result = headerOrRegular(data);
  result.forEach((listItem) {
    return listItem;
  });
}


// redo to dart from movieParcer -Repository-sortAndFilterValues
List<ListViewItem> headerOrRegular(List<MoviePOJO> unsortedList) {
  var sortedListByDate = unsortedList.sort((a, b) =>
      a.releaseDate.compareTo(b.releaseDate));
  DateFormat fullDateFormat = DateFormat(DATE_FORMAT_FULL);
  DateFormat shortDateFormat = DateFormat(DATE_FORMAT_SHORT);

  data.forEach((it) {
    var releaseDate = it.releaseDate;
    var dateFull = fullDateFormat.parse(it.releaseDate);
    var dateShort = shortDateFormat.format(dateFull);
    var cal =
  });
}
