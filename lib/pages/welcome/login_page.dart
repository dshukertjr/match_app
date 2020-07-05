import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/pages/welcome/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            SizedBox(height: 24),
            RaisedButton(
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                final email = _emailController.text;
                final password = _passwordController.text;
                BlocProvider.of<AuthBloc>(context).add(AuthLoggedin(
                  email: email,
                  password: password,
                ));
              },
              child: Text('ログイン'),
            ),
            SizedBox(height: 24),
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(RegisterPage.route());
              },
              child: Text('アカウントのない方はこちら'),
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
