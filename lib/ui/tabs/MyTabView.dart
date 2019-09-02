import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/ui/list_view/myListView.dart';

class MyTabView extends StatelessWidget {
  final String bodyContent;

  const MyTabView({Key key, this.bodyContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(child: myListView(context)),
    );
  }
}