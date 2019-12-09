import 'package:flutter_genesis_test/data_classes/movie_inner.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

import '../../ui/ui_utils/constants.dart';

String getCurrentTimeAndFormat() {
  DateTime now = DateTime.now();
  var formatter = DateFormat(DATE_FORMAT_FULL);
  DateTime date = DateTime(now.year, now.month, now.day);
  var formattedDate = formatter.format(date);
  return formattedDate;
}

String getFutureTimeAndFormat() {
  DateTime now = DateTime.now();
  var formatter = DateFormat(DATE_FORMAT_FULL);
  DateTime date = DateTime(now.year, now.month + 3, now.day);
  var formattedDate = formatter.format(date);
  return formattedDate;
}

bool fromJsonToBool(int toTransform) {
  var result = toTransform == 1;
  return result;
}

void doShare(MovieInner movieToShare) {
  Share.share("movie's id is ${movieToShare.id}, title is ${movieToShare.title}, overview is ${movieToShare.overview}");
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
