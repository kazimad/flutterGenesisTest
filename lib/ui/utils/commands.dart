import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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