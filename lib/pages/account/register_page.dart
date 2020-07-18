import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/utilities/app_snackbar.dart';
import 'package:app/utilities/navitate_on_auth_state_change.dart';
import 'package:app/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class RegisterPage extends StatefulWidget {
  static const String name = 'RegisterPage';
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      settings: const RouteSettings(name: name),
      builder: (_) => RegisterPage(),
    );
  }

  /// key for getting the email field in testing
  @visibleForTesting
  static const Key registerPageEmailTextFieldKey = Key('registerEmail');

  /// key for getting the password field in testing
  @visibleForTesting
  static const Key registerPagePasswordTextFieldKey = Key('registerPassword');

  /// key for accessing the register button in testing
  @visibleForTesting
  static const Key registerPageSubmitButtonKey = Key('registerSubmitButton');

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// form key for validating the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
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
              decoration: const InputDecoration(
                labelText: 'メールアドレス',
              ),
              validator: emailValidator,
            ),
            const SizedBox(height: 24),
            TextFormField(
              key: RegisterPage.registerPagePasswordTextFieldKey,
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'パスワード',
              ),
              validator: passwordValidator,
            ),
            const SizedBox(height: 24),
            CubitConsumer<AuthCubit, AuthState>(
              listener: (BuildContext context, AuthState state) {
                navigateOnAuthStateChange(context, state);
                if (state.errorMessage != null) {
                  AppSnackbar.error(
                      context: context, message: state.errorMessage);
                }
              },
              builder: (BuildContext context, AuthState state) {
                Widget buttonChild = const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
                bool buttonDisabled = true;
                if (state is AuthNoUser) {
                  buttonChild = const Text('登録する');
                  buttonDisabled = false;
                }
                return RaisedButton(
                  key: RegisterPage.registerPageSubmitButtonKey,
                  onPressed: buttonDisabled
                      ? null
                      : () {
                          final bool isValid = _formKey.currentState.validate();
                          if (!isValid) {
                            return;
                          }
                          final String email = _emailController.text;
                          final String password = _passwordController.text;
                          CubitProvider.of<AuthCubit>(context).register(
                            email: email,
                            password: password,
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
