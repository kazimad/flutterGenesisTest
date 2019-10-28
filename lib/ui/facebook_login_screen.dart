import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookLoginScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<FacebookLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Click button to go to Main Page'),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text('Facebook login'),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
