import 'package:flutter/cupertino.dart';

class ErrorWidget extends StatelessWidget {
  final String error;

  ErrorWidget({@required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("$error"));
  }
}
