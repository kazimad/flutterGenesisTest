import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/movie_POJO.dart';
import 'package:flutter_genesis_test/ui/list_view/list_view_item.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';
import 'package:intl/intl.dart';

class ListViewPosts extends StatelessWidget {
  final List<MoviePOJO> posts;

  ListViewPosts({this.posts});

  @override
  Widget build(BuildContext context) {
//    print("ListViewPosts Widget build posts.length is ${posts.length}");
  final widgets = headerOrRegular(posts);

    return Container(
//        child: ListView(
//      children: <Widget>[
//        ...headerOrRegular(posts),
//      ],
//    )
//          itemCount: posts.length,
//          padding: const EdgeInsets.all(15.0),
//          itemBuilder: (context, position) {
//            return createList(posts);
//          }),
      child: ListView.builder(
          itemCount: posts.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
//            return createList(posts);
            return widgets[position];
          }),
        );
  }
}

createList(List<MoviePOJO> data) {
  print("ListViewPosts data ${data.length}");

  var result = headerOrRegular(data);
  print("ListViewPosts result ${result.length}");

  result.forEach((listItem) {
    print("ListViewPosts listItem is ${listItem.toString()}");
    return listItem;
  });
}

// redo to dart from movieParcer -Repository-sortAndFilterValues
List<Widget> headerOrRegular(List<MoviePOJO> incommingList) {
  final technical = <Widget>[];

  incommingList.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
  DateFormat fullDateFormat = DateFormat(DATE_FORMAT_FULL);
  DateFormat shortDateFormat = DateFormat(DATE_FORMAT_SHORT);
  int currentMonth = -1;

  // separate by month
  // list is already sortedBy release month

  incommingList.forEach((it) {
    var releaseDate = it.releaseDate;
    var dateFull = fullDateFormat.parse(releaseDate);
    var dateShort = shortDateFormat.format(dateFull);
    var month = dateFull.month;
    if (month != currentMonth) {
      technical.add(HeaderItem(dateShort));
      technical.add(RegularItem(movie: it));
      currentMonth = month;
    } else {
      technical.add(RegularItem(movie: it));
    }
  });

  print("technical.length is ${technical.length}");
//  //separate values in each collection by dates
//  HashMap<String, List<ListViewItem>> rawHashMap =
//      HashMap<String, List<ListViewItem>>();
//  List<ListViewItem> array;
//  String lastKey;
//  technical.forEach((each) {
//    if (each is HeaderItem) {
//      if (lastKey != null) {
//        rawHashMap[lastKey] = array;
//      }
//      lastKey = each.headerText;
//      array = List();
//    } else {
////      if (array != null && array.isNotEmpty) {
//        array.add(each);
////      }
//    }
//  });
//
//  rawHashMap[lastKey] = array;
//
//  //sort each value list by popularity
//  HashMap<String, List<ListViewItem>> sortedHashMap = HashMap<String, List<ListViewItem>>();
//  print("rawHashMap length is ${rawHashMap.length}");
//  rawHashMap.entries.forEach((entry) {
//    sortedHashMap[entry.key] = entry.value..sort();
//    print("entry is ${entry.value.length}");
//
//  });
//
//  // compose sorted values and headers
//  List<ListViewItem> sortedFilteredResult = List<ListViewItem>();
//  sortedHashMap.entries.forEach((entry) {
//    if (entry.value != null) {
//      sortedFilteredResult.add(HeaderItem(entry.key));
//      sortedFilteredResult.addAll(entry.value);
//    }
//  });
//
//  print("sortedFilteredResult.length is ${sortedFilteredResult.length}");
//  return sortedFilteredResult;
  return technical;
}
