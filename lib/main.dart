import 'package:flutter/material.dart';
import 'package:flutter_genesis_test/ui/facebook_login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final double avatarSize = 40;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: FacebookLoginScreen());
  }
}
