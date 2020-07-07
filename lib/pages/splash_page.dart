import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/utilities/auth_navigator.dart';
import 'package:app/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

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
      body: CubitListener<AuthCubit, AuthState>(
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
