import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  static const name = 'RegisterPage';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: name),
      builder: (context) => RegisterPage(),
    );
  }

  /// key for getting the email field in testing
  @visibleForTesting
  static const registerPageEmailTextFieldKey = Key('registerEmail');

  /// key for getting the password field in testing
  @visibleForTesting
  static const registerPagePasswordTextFieldKey = Key('registerPassword');

  /// key for accessing the register button in testing
  @visibleForTesting
  static const registerPageSubmitButtonKey = Key('registerSubmitButton');

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// form key for validating the form
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
              key: RegisterPage.registerPageEmailTextFieldKey,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'メールアドレス',
              ),
              validator: Validator.emailValidator,
            ),
            SizedBox(height: 24),
            TextFormField(
              key: RegisterPage.registerPagePasswordTextFieldKey,
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'パスワード',
              ),
              validator: Validator.passwordValidator,
            ),
            SizedBox(height: 24),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                Widget buttonChild = SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
                bool buttonDisabled = true;
                if (state is AuthNoUser) {
                  buttonChild = Text('登録する');
                  buttonDisabled = false;
                }
                return RaisedButton(
                  key: RegisterPage.registerPageSubmitButtonKey,
                  onPressed: buttonDisabled
                      ? null
                      : () {
                          final isValid = _formKey.currentState.validate();
                          if (!isValid) {
                            return;
                          }
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthRegistered(
                              email: email,
                              password: password,
                            ),
                          );
                        },
                  child: buttonChild,
                );
              },
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
