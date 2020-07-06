import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/pages/account/enter_profile_page.dart';
import 'package:app/pages/account/login_page.dart';
import 'package:app/utilities/auth_navigator.dart';
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
          AuthNavigator.onAuthStateChanged(context, state);
        },
        child: Center(
          child: CustomLoader(),
        ),
      ),
    );
  }
}
