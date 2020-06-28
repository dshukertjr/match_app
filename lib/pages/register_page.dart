import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  static const name = 'RegisterPage';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: name),
      builder: (context) => RegisterPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
    );
  }
}
