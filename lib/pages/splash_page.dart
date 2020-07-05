import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/pages/welcome/login_page.dart';
import 'package:app/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  static const name = 'SplashPage';
  static Route<dynamic> route() {
    return MaterialPageRoute(
      settings: RouteSettings(
        name: name,
      ),
      builder: (context) => SplashPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthNoUser) {
            Navigator.of(context).pushAndRemoveUntil(
              LoginPage.route(),
              (route) => false,
            );
          } else if (state is AuthNoProfile) {
          } else if (state is AuthSuccess) {}
        },
        child: Center(
          child: CustomLoader(),
        ),
      ),
    );
  }
}
