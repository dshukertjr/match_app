import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const name = 'LoginPage';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      settings: RouteSettings(
        name: name,
      ),
      builder: (context) => LoginPage(),
    );
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'メールアドレス',
              ),
            ),
            SizedBox(height: 24),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'パスワード',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
