import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/utilities/auth_navigator.dart';
import 'package:app/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class SplashPage extends StatelessWidget {
  static const String name = 'SplashPage';
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      settings: const RouteSettings(
        name: name,
      ),
      builder: (_) => SplashPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CubitListener<AuthCubit, AuthState>(
        listener: (BuildContext context, AuthState state) {
          navigateOnAuthStateChanged(context, state);
        },
        child: Center(
          child: CustomLoader(),
        ),
      ),
    );
  }
}
