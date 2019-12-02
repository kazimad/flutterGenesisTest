import 'package:flutter/material.dart';

class MyTab extends StatelessWidget {
  final String tabName;

  const MyTab(this.tabName);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(tabName.toUpperCase()),
    );
  }
}