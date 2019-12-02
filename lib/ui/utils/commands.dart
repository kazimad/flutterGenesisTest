import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

import 'constants.dart';

Future<void> showErrorMessage(BuildContext context, String whatToShow) async {
  await Future<void>.microtask(() {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text(whatToShow)),
    );
  });
}

bool isNotNullAndNotEmpty(String stringToCheck) {
  if (stringToCheck == null) {
    return false;
  } else if (stringToCheck.isEmpty) {
    return false;
  } else {
    return true;
  }
}

String getCurrentTimeAndFormat() {
  DateTime now = new DateTime.now();
  var formatter = new DateFormat(DATE_FORMAT_FULL);
  DateTime date = new DateTime(now.year, now.month, now.day);
  var formattedDate = formatter.format(date);
  return formattedDate;
}

String getFutureTimeAndFormat() {
  DateTime now = new DateTime.now();
  var formatter = new DateFormat(DATE_FORMAT_FULL);
  DateTime date = new DateTime(now.year, now.month + 3, now.day);
  var formattedDate = formatter.format(date);
  return formattedDate;
}

bool fromJsonToBool(int toTransform) {
  var result = toTransform == 1;
  return result;
}

String properText(MovieInner movieInner) {
  if (movieInner.isFavorite) {
    return S.of(context).remove_from_favorite.toUpperCase();
  } else {
    return S.of(context).add_to_favorite.toUpperCase();
  }
}

void doShare(MovieInner movieToShare) {
  Share.share(
      "movie's id is ${movieToShare.id}, title is ${movieToShare.title}, overview is ${movieToShare.overview}");
}

Widget buildLoadingWidget() {
  return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(S.of(context).loading_data_from_api), CircularProgressIndicator()],
      ));
}

Widget buildErrorWidget(String error) {
  return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$error"),
        ],
      ));
}
