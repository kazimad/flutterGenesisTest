import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_genesis_test/ui/utils/commands.dart';
import 'package:http/http.dart' as http;

import 'main_screen.dart';

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
                _facebookLogin(context);
              },
            )
          ],
        ),
      ),
    );
  }

  _facebookLogin(BuildContext context) async {
    final FacebookLogin facebookLogin = new FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        showErrorMessage(context, "facebook login ok - ${result.accessToken.token}");
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${result.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        _navigateToNextScreen(profile);
        break;
      case FacebookLoginStatus.cancelledByUser:
        showErrorMessage(context, "facebook login cancelled");
        break;
      case FacebookLoginStatus.error:
        showErrorMessage(context, "facebook login cancelled with error ${result.errorMessage}");
        break;
    }
  }

  _navigateToNextScreen(dynamic avatarToLoadString) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(avatarToLoadString)));
  }
}
