import 'dart:collection';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/ui/list_view/list_view_movie_item.dart';
import 'package:flutter_genesis_test/ui/utils/constants.dart';
import 'package:intl/intl.dart';

class ListViewMovies extends StatelessWidget {
  final List<MovieInner> movies;
  final Key key;
  final SourceTab source;

  ListViewMovies({this.movies, this.source, this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgets = headerOrRegular(movies, source);

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

List<ListViewMovieItem> headerOrRegular(List<MovieInner> incomingList, SourceTab source) {
  final technical = <ListViewMovieItem>[];

  incomingList.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
  DateFormat fullDateFormat = DateFormat(DATE_FORMAT_FULL);
  DateFormat shortDateFormat = DateFormat(DATE_FORMAT_SHORT);
  int currentMonth = -1;

  incomingList.forEach((it) {
    var releaseDate = it.releaseDate;
    var dateFull = fullDateFormat.parse(releaseDate);
    var dateShort = shortDateFormat.format(dateFull);
    var month = dateFull.month;
    if (month != currentMonth) {
      technical.add(HeaderItem(dateShort));
      technical.add(RegularItem(movie: it, source: source, key: Key("regular")));
      currentMonth = month;
    } else {
      technical.add(RegularItem(movie: it, source: source, key: Key("regular")));
    }
  });

  //separate values in each collection by dates
  LinkedHashMap<String, List<ListViewMovieItem>> rawHashMap = LinkedHashMap<String, List<ListViewMovieItem>>();
  List<ListViewMovieItem> array;
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
    entry.value.sort((a, b) => (a as RegularItem).movie.popularity.compareTo((b as RegularItem).movie.popularity));
  });
  // compose sorted values and headers
  List<ListViewMovieItem> sortedFilteredResult = List<ListViewMovieItem>();
  rawHashMap.entries.forEach((entry) {
    sortedFilteredResult.add(HeaderItem(entry.key));
    sortedFilteredResult.addAll(entry.value);
  });
  return sortedFilteredResult;
}
