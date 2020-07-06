import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/pages/account/enter_profile_page.dart';
import 'package:app/pages/account/login_page.dart';
import 'package:flutter/material.dart';

/// Class that will navigate user depending on the auth state
class AuthNavigator {
  /// Navigate users to the correct page depending on the auth state
  static void Function(BuildContext, AuthState) onAuthStateChanged =
      (context, state) {
    if (state is AuthNoUser) {
      Navigator.of(context).pushAndRemoveUntil(
        LoginPage.route(),
        (route) => false,
      );
    } else if (state is AuthNoProfile) {
      Navigator.of(context).pushAndRemoveUntil(
        EnterProfilePage.route(),
        (route) => false,
      );
    } else if (state is AuthSuccess) {}
  };
}
