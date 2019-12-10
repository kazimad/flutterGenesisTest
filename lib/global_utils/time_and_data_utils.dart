import 'package:flutter_genesis_test/ui/ui_utils/constants.dart';
import 'package:intl/intl.dart';

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
