import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/pages/account/register_page.dart';
import 'package:app/utilities/app_snackbar.dart';
import 'package:app/utilities/auth_navigator.dart';
import 'package:app/utilities/validator.dart';
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

  @visibleForTesting
  static const loginPageEmailTextFormFieldKey =
      Key('loginPageEmailTextFormField');

  @visibleForTesting
  static const loginPagePasswordTextFormFieldKey =
      Key('loginPagePasswordTextFormField');

  @visibleForTesting
  static const loginButtonKey = Key('loginButtonKey');

  @visibleForTesting
  static const openRegisterPageKey = Key('openRegisterPageKey');

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
              key: LoginPage.loginPageEmailTextFormFieldKey,
              validator: Validator.emailValidator,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'メールアドレス',
              ),
            ),
            SizedBox(height: 24),
            TextFormField(
              key: LoginPage.loginPagePasswordTextFormFieldKey,
              validator: Validator.passwordValidator,
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'パスワード',
              ),
            ),
            SizedBox(height: 24),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                AuthNavigator.onAuthStateChanged(context, state);
                if (state.errorMessage != null) {
                  AppSnackbar.error(
                      context: context, message: state.errorMessage);
                }
              },
              builder: (context, state) {
                Widget buttonChild = SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
                bool buttonDisabled = true;
                if (state is AuthNoUser) {
                  buttonChild = Text('ログイン');
                  buttonDisabled = false;
                }
                return RaisedButton(
                  key: LoginPage.loginButtonKey,
                  onPressed: buttonDisabled
                      ? null
                      : () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthLoggedin(
                              email: email,
                              password: password,
                            ),
                          );
                        },
                  child: buttonChild,
                );
              },
            ),
            SizedBox(height: 24),
            FlatButton(
              key: LoginPage.openRegisterPageKey,
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
