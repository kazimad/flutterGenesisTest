import 'package:flutter/material.dart';

class Commands {
  static showSnackBar(context, String whatToShow) {
    Scaffold.of(context)
        .showSnackBar(new SnackBar(content: new Text(whatToShow)));
  }
}
