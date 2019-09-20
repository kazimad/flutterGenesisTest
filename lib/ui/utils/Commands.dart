import 'package:flutter/material.dart';

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
