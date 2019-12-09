import 'dart:collection';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/ui/list_view_widgets/list_item_widget.dart';
import 'package:flutter_genesis_test/ui/list_view_widgets/source_tab.dart';
import 'package:flutter_genesis_test/ui/ui_utils/constants.dart';
import 'package:intl/intl.dart';

class ListViewMoviesWidget extends StatelessWidget {
  final List<MovieInner> movies;
  final SourceTab source;

  ListViewMoviesWidget({@required this.movies, @required this.source});

  @override
  Widget build(BuildContext context) {
    final widgets = _sortAndAddHeaderItems(movies, source);

    return Container(
      child: ListView.builder(
          itemCount: widgets.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return widgets[position];
          }),
    );
  }
}

List<ListViewMovieItemWidget> _sortAndAddHeaderItems(List<MovieInner> incomingList, SourceTab source) {
  final technical = <ListViewMovieItemWidget>[];

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
      technical.add(HeaderItemWidget(dateShort));
      technical.add(RegularItemWidget(movie: it, source: source));
      currentMonth = month;
    } else {
      technical.add(RegularItemWidget(movie: it, source: source));
    }
  });

  //separate values in each collection by dates
  LinkedHashMap<String, List<ListViewMovieItemWidget>> rawHashMap = LinkedHashMap<String, List<ListViewMovieItemWidget>>();
  List<ListViewMovieItemWidget> array;
  String lastKey;
  technical.forEach((each) {
    if (each is HeaderItemWidget) {
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
    entry.value.sort((a, b) => (a as RegularItemWidget).movie.popularity.compareTo((b as RegularItemWidget).movie.popularity));
  });
  // compose sorted values and headers
  List<ListViewMovieItemWidget> sortedFilteredResult = List<ListViewMovieItemWidget>();
  rawHashMap.entries.forEach((entry) {
    sortedFilteredResult.add(HeaderItemWidget(entry.key));
    sortedFilteredResult.addAll(entry.value);
  });
  return sortedFilteredResult;
}
