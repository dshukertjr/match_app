import 'package:app/pages/welcome/register_page.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  static const name = 'WelcomePage';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => WelcomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(LoginPage.route());
            },
            child: Text('ログイン'),
          ),
          SizedBox(height: 24),
          RaisedButton(
            key: Key('welcomeRegisterButton'),
            onPressed: () {
              Navigator.of(context).push(RegisterPage.route());
            },
            child: Text('新規登録'),
          ),
        ],
      ),
    );
  }
}
