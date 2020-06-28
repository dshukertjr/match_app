import 'package:app/utilities/validator.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  static const name = 'RegisterPage';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: name),
      builder: (context) => RegisterPage(),
    );
  }

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新規登録'),
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
              validator: Validator.emailValidator,
            ),
            SizedBox(height: 24),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'パスワード',
              ),
              validator: Validator.passwordValidator,
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
