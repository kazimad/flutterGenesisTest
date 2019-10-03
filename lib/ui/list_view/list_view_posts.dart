import 'dart:collection';
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
    final widgets = headerOrRegular(posts);

    return Container(
      child: ListView.builder(
          itemCount: widgets.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return widgets[position] as Widget;
          }),
    );
  }
}

createList(List<MoviePOJO> data) {
  var result = headerOrRegular(data);
  result.forEach((listItem) {
    return listItem;
  });
}

List<ListViewItem> headerOrRegular(List<MoviePOJO> incommingList) {
  final technical = <ListViewItem>[];

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

  //separate values in each collection by dates
  LinkedHashMap<String, List<ListViewItem>> rawHashMap =
      LinkedHashMap<String, List<ListViewItem>>();
  List<ListViewItem> array;
  String lastKey;
  technical.forEach((each) {
    if (each is HeaderItem) {
      if (lastKey != null) {
        rawHashMap[lastKey] = array;
      }
      lastKey = each.headerText;
      array = List();
    } else {
      array.add(each);
    }
  });
  rawHashMap[lastKey] = array;
  //sort each value list by popularity
  rawHashMap.entries.forEach((entry) {
    entry.value.sort((a, b) => (a as RegularItem)
        .movie
        .popularity
        .compareTo((b as RegularItem).movie.popularity));
  });
  // compose sorted values and headers
  List<ListViewItem> sortedFilteredResult = List<ListViewItem>();
  rawHashMap.entries.forEach((entry) {
    sortedFilteredResult.add(HeaderItem(entry.key));
    sortedFilteredResult.addAll(entry.value);
  });
  return sortedFilteredResult;
}
