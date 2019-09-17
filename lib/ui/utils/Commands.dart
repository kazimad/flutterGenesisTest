import 'package:flutter/material.dart';

showErrorMessage(context, String whatToShow) {
  Scaffold.of(context).showSnackBar(
    SnackBar(content: Text(whatToShow)),
  );
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
