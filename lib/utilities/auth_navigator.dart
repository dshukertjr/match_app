import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/pages/account/enter_profile_page.dart';
import 'package:app/pages/account/login_page.dart';
import 'package:app/pages/tab_page.dart';
import 'package:flutter/material.dart';

/// Navigate users to the correct page depending on the auth state
void Function(BuildContext, AuthState) navigateOnAuthStateChanged =
    (BuildContext context, AuthState state) {
  if (!ModalRoute.of(context).isCurrent) {
    return;
  }
  if (state is AuthNoUser) {
    Navigator.of(context).pushAndRemoveUntil<void>(
      LoginPage.route(),
      (_) => false,
    );
  } else if (state is AuthNoProfile) {
    Navigator.of(context).pushAndRemoveUntil<void>(
      EnterProfilePage.route(),
      (_) => false,
    );
  } else if (state is AuthSuccess) {
    Navigator.of(context).pushAndRemoveUntil<void>(
      TabPage.route(),
      (_) => false,
    );
  }
};
