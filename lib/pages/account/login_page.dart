import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/pages/account/register_page.dart';
import 'package:app/utilities/app_snackbar.dart';
import 'package:app/utilities/auth_navigator.dart';
import 'package:app/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class LoginPage extends StatefulWidget {
  static const String name = 'LoginPage';
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      settings: const RouteSettings(name: name),
      builder: (_) => LoginPage(),
    );
  }

  @visibleForTesting
  static const Key loginPageEmailTextFormFieldKey =
      Key('loginPageEmailTextFormField');

  @visibleForTesting
  static const Key loginPagePasswordTextFormFieldKey =
      Key('loginPagePasswordTextFormField');

  @visibleForTesting
  static const Key loginButtonKey = Key('loginButtonKey');

  @visibleForTesting
  static const Key openRegisterPageKey = Key('openRegisterPageKey');

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              key: LoginPage.loginPageEmailTextFormFieldKey,
              validator: emailValidator,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'メールアドレス',
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              key: LoginPage.loginPagePasswordTextFormFieldKey,
              validator: passwordValidator,
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'パスワード',
              ),
            ),
            const SizedBox(height: 24),
            CubitConsumer<AuthCubit, AuthState>(
              listener: (BuildContext context, AuthState state) {
                navigateOnAuthStateChanged(context, state);
                if (state.errorMessage != null) {
                  AppSnackbar.error(
                      context: context, message: state.errorMessage);
                }
              },
              builder: (BuildContext context, AuthState state) {
                Widget buttonChild = const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
                bool buttonDisabled = true;
                if (state is AuthNoUser) {
                  buttonChild = const Text('ログイン');
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
                          final String email = _emailController.text;
                          final String password = _passwordController.text;
                          CubitProvider.of<AuthCubit>(context)
                              .login(email: email, password: password);
                        },
                  child: buttonChild,
                );
              },
            ),
            const SizedBox(height: 24),
            FlatButton(
              key: LoginPage.openRegisterPageKey,
              onPressed: () {
                Navigator.of(context).push<dynamic>(RegisterPage.route());
              },
              child: const Text('アカウントのない方はこちら'),
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
