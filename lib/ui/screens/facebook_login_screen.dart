import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_genesis_test/exception/custom_exception.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';
import 'package:flutter_genesis_test/ui/screens/main_screen.dart';
import 'package:flutter_genesis_test/ui/utils/commands/commands_ui.dart';


class FacebookLoginScreen extends StatefulWidget {
  final FacebookLogin facebookLogin = new FacebookLogin();

  @override
  _State createState() => _State();
}

class _State extends State<FacebookLoginScreen> {
  @override
  void initState() {
    super.initState();
    _checkIsUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(S.of(context).click_button_to_go_to_main_page),
            Builder(
              builder: (ctx) => RaisedButton(
                textColor: Colors.white,
                color: Colors.green,
                child: Text(S.of(context).facebook_login),
                onPressed: () {
                  _facebookLogin(ctx);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _checkIsUserLoggedIn() async {
    bool isLoggedIn = await widget.facebookLogin.isLoggedIn;
    if (isLoggedIn) {
      FacebookAccessToken facebookAccessToken = await widget.facebookLogin.currentAccessToken;
      _navigateToNextScreen(facebookAccessToken.token);
    }
  }

  _facebookLogin(BuildContext context) async {
    final result = await widget.facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _navigateToNextScreen(result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        showErrorMessage(context, CustomException(S.of(context).facebook_login_cancelled));
        break;
      case FacebookLoginStatus.error:
        showErrorMessage(context, CustomException((S.of(context).facebook_login_cancelled_with_error_result) + result.errorMessage));
        break;
      default:
        showErrorMessage(context, CustomException(S.of(context).some_error_with_facebook_login));
    }
  }

  _navigateToNextScreen(String token) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(token)));
  }
}
