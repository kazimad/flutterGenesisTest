import 'package:flutter/cupertino.dart';

class MovieErrorWidget extends StatelessWidget {
  final String error;

  MovieErrorWidget(this.error);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("$error"));
  }
}
